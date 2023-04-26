FROM golang:1.19.2-alpine3.15 as build
RUN echo -e http://mirrors.ustc.edu.cn/alpine/v3.15/main/ > /etc/apk/repositories
ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn
WORKDIR /opt/demo
RUN apk add --no-cache gcc musl-dev
COPY . /
RUN go build -ldflags="-s -w" -o webhook-server webhook-server/main.go

FROM scratch

COPY COPY --from=build /opt/webhook-server /
ENTRYPOINT ["/webhook-server"]
