FROM golang:alpine AS build

RUN apk add --no-cache -U make

COPY . /src/goproxy
RUN cd /src/goproxy &&\
    export CGO_ENABLED=0 &&\
    make

FROM alpine:latest

RUN apk add --no-cache -U git mercurial subversion 

COPY --from=build /src/goproxy/bin/goproxy /goproxy

VOLUME /go

EXPOSE 8081

ENTRYPOINT ["/goproxy"]
CMD []
