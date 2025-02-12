FROM docker.io/nixos/nix AS builder

WORKDIR /app
COPY . .
RUN nix-shell -A build

FROM docker.io/library/alpine:latest
WORKDIR /app

COPY --from=builder /app/video-lucu /app/video-lucu
COPY --from=builder /app/src /app/src

EXPOSE 8080
CMD ["/app/video-lucu"]
