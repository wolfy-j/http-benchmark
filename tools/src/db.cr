require "admiral"
require "pg"
require "crustache"

class App < Admiral::Command
  class ReadmeWriter < Admiral::Command
    def run
      results = {} of String => Hash(String, String | Float64 | Float32)
      order_by_requests = <<-EOS
SELECT f.id, l.label, f.label, k.label, v.value
  FROM values AS v 
  JOIN metrics AS m ON m.value_id = v.id 
  JOIN keys AS k ON v.key_id = k.id 
  JOIN frameworks AS f ON f.id = m.framework_id 
  JOIN languages AS l ON l.id = f.language_id
      ORDER BY k.label=$1 desc, v.value
EOS
      DB.open("postgresql://postgres@localhost/benchmark") do |db|
        db.query order_by_requests, "percentile_fifty" do |row|
          row.each do
            key = row.read(Int).to_s
            language = row.read(String)
            framework = row.read(String)
            metric = row.read(String).to_s
            value = row.read(Float)
            unless results.has_key?(key)
              results[key] = {} of String => (String | Float64 | Float32)
              results[key]["language"] = language
              results[key]["framework"] = framework
            end
            results[key][metric] = value
          end
        end
      end
      lines = [
        "| Language | Framework | Average | 50th percentile | 90th percentile | 99th percentile | 99.9th percentile | Standard deviation | Requests / s | Throughput |",
        "|----|----|---------|-------------|---------|----------|----------|------|------|-------|",
      ]
      results.each do |_, row|
        lines << "| %s | %s | %.2f ms | **%.2f** ms | %.2f ms | %.2f ms  | %.2f ms  | %.2f | %.2f | %.2f Mb |" % [
          row["language"],
          row["framework"],
          row["latency_average"].to_f/1000,
          row["percentile_fifty"].to_f/1000,
          row["percentile_ninety"].to_f/1000,
          row["percentile_ninety_nine"].to_f/1000,
          row["percentile_ninety_nine_ninety"].to_f/1000,
          row["latency_deviation"].to_f,
          row["request_per_second"].to_f,
          row["request_bytes"].to_f / row["request_duration"].to_f,
        ]
      end

      path = File.expand_path("../../../README.mustache.md", __FILE__)
      template = Crustache.parse(File.read(path))
      puts Crustache.render template, {"results" => lines}
    end
  end

  register_sub_command to_readme : ReadmeWriter, description "Update readme with results"

  def run
    puts "help"
  end
end

App.run
