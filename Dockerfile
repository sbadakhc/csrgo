# build
FROM golang:1.12-alpine as builder
RUN             apk add --no-cache git 
WORKDIR         /home/sbadakhc/work/src/github.com/xencon/csrgo
ENV             GO111MODULE=on
COPY            go.mod go.sum ./
RUN             go mod download
COPY            . ./
RUN             go build -o . -ldflags "-extldflags \"-static\"" -v

# minimal runtime
FROM            alpine
COPY            --from=builder /csrgo /csrgo
WORKDIR         /
ENTRYPOINT      ["/csrgo"]
