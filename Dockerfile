FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    build-essential git && \
    git clone https://github.com/usadmin/simpleproxy.git /simpleproxy && \
    cd /simpleproxy && make && \
    cp simpleproxy /usr/local/bin && \
    chmod +x /usr/local/bin/simpleproxy && \
    cd / && rm -rf /simpleproxy && \
    apt-get remove --purge -y build-essential git && \
    apt-get autoremove -y && apt-get clean

EXPOSE ${PROXY_PORT}

CMD ["sh", "-c", "simpleproxy -L ${PROXY_PORT} -R ${TARGET_HOST}:${TARGET_PORT}"]
