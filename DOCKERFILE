FROM alpine:latest

RUN apk add --no-cache simpleproxy

# Miljövariabler för konfiguration
#ENV PROXY_PORT=5000
#ENV TARGET_HOST=host.docker.internal
#ENV TARGET_PORT=8000

CMD ["sh", "-c", "simpleproxy -L ${PROXY_PORT} -R ${TARGET_HOST}:${TARGET_PORT}"]
