FROM alpine:latest

RUN apk add --no-cache bash procps

WORKDIR /app

COPY monitor.sh .

RUN chmod +x monitor.sh

ENTRYPOINT ["/app/monitor.sh"]
