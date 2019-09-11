FROM golang:1.13

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
ENV GOPROXY=https://proxy.golang.org

WORKDIR /go/src/app
COPY . ./
RUN rm -fr go.sum

RUN go get
RUN go build -a -ldflags '-extldflags "-static"' -o /go/bin/app ./

FROM ubuntu
COPY --from=0 /go/bin/app /usr/bin/app
CMD /usr/bin/app
