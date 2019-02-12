FROM golang:1.12beta2-alpine3.9 AS build-env

ENV CGO_ENABLED 0

# Allow Go to retrive the dependencies for the build step
RUN apk add --no-cache git

WORKDIR /awesomeProject9/
ADD . /awesomeProject9/

# Compile the binary, we don't want to run the cgo resolver
RUN go build -o /awesomeProject9/srv .

WORKDIR /go/src/
RUN go get github.com/go-delve/delve/cmd/dlv

# final stage
FROM alpine:3.9

WORKDIR /
COPY --from=build-env /awesomeProject9/srv /
COPY --from=build-env /go/bin/dlv /

EXPOSE 8080 40000

CMD ["/dlv", "--listen=:40000", "--headless=true", "--api-version=2", "exec", "/srv"]
