FROM alpine:latest

RUN apk add --no-cache build-base git

# Klona och bygg simpleproxy
RUN git clone https://github.com/usadmin/simpleproxy.git /simpleproxy && \
    cd /simpleproxy && \
    make && \
    cp simpleproxy /usr/local/bin && \
    chmod +x /usr/local/bin/simpleproxy && \
    cd / && rm -rf /simpleproxy && \
    apk del build-base git

# Miljövariabler för konfiguration
#ENV PROXY_PORT=5000
#ENV TARGET_HOST=host.docker.internal
#ENV TARGET_PORT=8000

EXPOSE ${PROXY_PORT}

CMD ["sh", "-c", "simpleproxy -L ${PROXY_PORT} -R ${TARGET_HOST}:${TARGET_PORT}"]
