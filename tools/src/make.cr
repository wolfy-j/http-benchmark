require "admiral"
require "yaml"
require "crustache"

alias DockerVariable = String | Array(String)

struct FrameworkConfig
  property name : String
  property website : String
  property version : Float32
  property langver : Float32 | String

  def initialize(@name, @website, @version, @langver)
  end
end

class App < Admiral::Command
  class Config < Admiral::Command
    def run
      frameworks = {} of String => Array(String)
      Dir.glob("*/*/config.yaml").each do |file|
        directory = File.dirname(file)
        infos = directory.split("/")
        framework = infos.pop
        language = infos.pop

        unless frameworks.has_key?(language)
          frameworks[language] = [] of String
        end

        frameworks[language] << framework
      end

      selection = YAML.build do |yaml|
        yaml.mapping do
          yaml.scalar "main"
          yaml.mapping do
            yaml.scalar "depends_on"
            yaml.sequence do
              frameworks.each do |language, _|
                yaml.scalar language
              end
            end
          end
          frameworks.each do |language, tools|
            yaml.scalar language
            yaml.mapping do
              yaml.scalar "depends_on"
              yaml.sequence do
                tools.each do |tool|
                  yaml.scalar tool
                end
              end
            end
          end
          frameworks.each do |language, tools|
            lang_config = YAML.parse(File.read("#{language}/config.yaml"))
            dockerfile = Crustache.parse(File.read("#{language}/Dockerfile"))
            tools.each do |tool|
              params = {} of String => DockerVariable
              framework_config = YAML.parse(File.read("#{language}/#{tool}/config.yaml"))
              if framework_config.as_h.has_key?("environment")
                environment = [] of String
                framework_config["environment"].as_h.each do |k, v|
                  environment << "#{k} #{v}"
                end
                params["environment"] = environment
              end
              if framework_config.as_h.has_key?("arguments")
                params["arguments"] = framework_config["arguments"].to_s
              end
              if framework_config.as_h.has_key?("files")
                files = [] of String
                framework_config.as_h["files"].as_a.each do |file|
                  files << file.to_s
                end
                params["files"] = files
              end
              if framework_config.as_h.has_key?("command")
                params["command"] = framework_config.as_h["command"].to_s
              end
              File.write("#{language}/#{tool}/Dockerfile", Crustache.render(dockerfile, params))
              yaml.scalar tool
              yaml.mapping do
                yaml.scalar "commands"
                yaml.sequence do
                  yaml.scalar "docker build -t #{tool} ."
                  yaml.scalar "docker run -td #{tool} | xargs -i docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' {} > ip.txt"
                  yaml.scalar "../../bin/client -l #{language} -f #{tool} -r GET:/ -r GET:/user/0 -r POST:/user"
                  yaml.scalar "docker ps -a -q  --filter ancestor=#{tool} | xargs -i docker container rm -f {}"
                end
                yaml.scalar "dir"
                yaml.scalar "#{language}/#{tool}"
              end
            end
          end
        end
      end
      File.write("neph.yaml", selection)
    end
  end

  class TravisConfig < Admiral::Command
    def run
      frameworks = [] of String
      languages = [] of String
      mapping = YAML.parse(File.read(".ci/mapping.yml"))
      Dir.glob("*/*/config.yaml").each do |file|
        frameworks << file.split("/")[-2]
        languages << file.split("/")[-3]
      end
      selection = YAML.build do |yaml|
        yaml.mapping do
          yaml.scalar "jobs"
          yaml.mapping do
            yaml.scalar "include"
            yaml.sequence do
              frameworks.sort.each do |framework|
                begin
                  yaml.mapping do
                    yaml.scalar "stage"
                    yaml.scalar "test"
                    yaml.scalar "script"
                    yaml.scalar "bash .ci/test.sh"
                    yaml.scalar "language"
                    yaml.scalar "crystal"
                    yaml.scalar "env"
                    yaml.scalar "FRAMEWORK=#{framework}"
                    yaml.scalar "services"
                    yaml.sequence do
                      yaml.scalar "docker"
                      yaml.scalar "redis"
                    end
                  end
                end
              end
            end
          end
          yaml.scalar "notifications"
          yaml.mapping do
            yaml.scalar "email"
            yaml.scalar false
          end
          yaml.scalar "before_install"
          yaml.scalar "bash .ci/has_to_run.sh || travis_terminate 0"
          yaml.scalar "dist"
          yaml.scalar "bionic"
        end
      end

      File.write(".travis.yml", selection)
    end
  end

  class DependabotConfig < Admiral::Command
    def run
      mapping = YAML.parse(File.read(".dependabot/mapping.yaml"))
      frameworks = {} of String => Array(String)
      Dir.glob("*/*/config.yaml").each do |file|
        directory = File.dirname(file)
        infos = directory.split("/")
        framework = infos.pop
        language = infos.pop

        unless frameworks.has_key?(language)
          frameworks[language] = [] of String
        end

        frameworks[language] << framework
      end
      selection = YAML.build do |yaml|
        yaml.mapping do
          yaml.scalar "version"
          yaml.scalar 1
          yaml.scalar "update_configs"

          yaml.sequence do
            frameworks.each do |language, tools|
              tools.each do |tool|
                language = "javascript" if language == "node" # FIXME
                if mapping["languages"].as_h[language]?
                  yaml.mapping do
                    yaml.scalar "package_manager"
                    yaml.scalar mapping["languages"][language]["label"]
                    yaml.scalar "update_schedule"
                    yaml.scalar mapping["languages"][language]["update_schedule"]
                    yaml.scalar "directory"
                    if language == "javascript"
                      yaml.scalar "node/#{tool}"
                    else
                      yaml.scalar "#{language}/#{tool}"
                    end
                    yaml.scalar "default_labels"
                    yaml.sequence do
                      yaml.scalar "language:#{language}"
                    end
                  end
                end
              end
              language = "node" if language == "javascript" # FIXME
              directory = "#{language}/#{frameworks[language].first}"
              yaml.mapping do
                yaml.scalar "package_manager"
                yaml.scalar "docker"
                yaml.scalar "update_schedule"
                yaml.scalar "daily"
                yaml.scalar "directory"
                yaml.scalar directory
                yaml.scalar "default_labels"
                yaml.sequence do
                  yaml.scalar "docker"
                end
              end
            end
          end
        end
      end
      File.write(".dependabot/config.yml", selection)
    end
  end

  register_sub_command config : Config, description "Create framework list"
  register_sub_command ci_config : TravisConfig, description "Create configuration file for CI"
  register_sub_command deps_config : DependabotConfig, description "Create configuration file for deps update bot"

  def run
    puts "help"
  end
end

App.run
