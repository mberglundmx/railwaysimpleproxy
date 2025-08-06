FROM alpine:latest

RUN apk add --no-cache build-base wget unzip

# Ladda ner simpleproxy som zip och extrahera
RUN wget https://github.com/usadmin/simpleproxy/archive/refs/heads/master.zip && \
    unzip master.zip && \
    cd simpleproxy-master && \
    make && \
    cp simpleproxy /usr/local/bin && \
    chmod +x /usr/local/bin/simpleproxy && \
    cd / && rm -rf simpleproxy-master master.zip && \
    apk del build-base wget unzip

EXPOSE ${PROXY_PORT}

CMD ["sh", "-c", "simpleproxy -L ${PROXY_PORT} -R ${TARGET_HOST}:${TARGET_PORT}"]
