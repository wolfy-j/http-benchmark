FROM crystallang/crystal:0.30.1 AS buildenv

WORKDIR /usr/src/app

COPY shard.yml ./
COPY src src

RUN shards build --production --release --no-debug --static
RUN mv bin/server /usr/bin/app

FROM alpine
COPY --from=buildenv /usr/bin/app /usr/bin/app
CMD /usr/bin/app
