FROM rwynn/monstache-builder-cache-rel6:1.0.3 AS builder

RUN git clone https://github.com/rwynn/monstache.git /app && \
    cd /app && \
    go mod download

WORKDIR /app/docker/plugin

COPY plugin/plugin.go plugin.go

RUN go mod download 
RUN go build -buildmode=plugin -o plugin.so plugin.go

#MAIN CONTAINER
FROM rwynn/monstache:6.4.3

WORKDIR /app

COPY monstache.toml monstache.config.toml
COPY --from=builder /app/docker/plugin/plugin.so plugin.so

ENTRYPOINT ["bin/monstache","-f", "monstache.config.toml"]

