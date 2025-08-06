FROM ubuntu:22.04

# Installera simpleproxy (finns i APT)
RUN apt-get update && \
    apt-get install -y simpleproxy && \
    rm -rf /var/lib/apt/lists/*

# Miljövariabler för konfiguration
#ENV PROXY_PORT=5000
#ENV TARGET_HOST=host.docker.internal
#ENV TARGET_PORT=8000

EXPOSE ${PROXY_PORT}

# Starta simpleproxy
CMD ["sh", "-c", "\
  echo 'Starting simpleproxy...'; \
  echo \"Listening on port: $PROXY_PORT\"; \
  echo \"Forwarding to: $TARGET_HOST:$TARGET_PORT\"; \
  simpleproxy -v -L $PROXY_PORT -R [$TARGET_HOST]:$TARGET_PORT"]
