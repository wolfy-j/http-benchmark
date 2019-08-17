FROM crystallang/crystal:0.30.1 AS buildenv

WORKDIR /usr/src/app

COPY .postcssrc.yml Procfile Procfile.dev brunch-config.js bs-config.js ./
COPY shard.yml tasks.cr ./
COPY db db
COPY public public
COPY src src
COPY static static
COPY config config
COPY tasks tasks

RUN echo '{}'  > public/manifest.json
RUN echo '{}'  > public/mix-manifest.json

RUN shards build --release --no-debug

RUN shards build --production --release --no-debug --static
RUN mv bin/server /usr/bin/app

ENV LUCKY_ENV production

FROM alpine
COPY --from=buildenv /usr/bin/app /usr/bin/app
CMD /usr/bin/app
