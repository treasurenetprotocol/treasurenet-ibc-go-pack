FROM golang:1.18 as builder

ENV GOPATH=""
ENV GOMODULE="on"

COPY go.mod .
COPY go.sum .

RUN go mod download

ADD testing testing
ADD modules modules
ADD LICENSE LICENSE

COPY Makefile .

RUN make build

FROM ubuntu:26.04

COPY --from=builder /go/build/simd /bin/simd

ENTRYPOINT ["simd"]
