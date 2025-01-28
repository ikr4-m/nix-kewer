FROM docker.io/nixos/nix AS builder

WORKDIR /app
COPY . .
RUN nix-shell -A build

FROM docker.io/library/alpine:latest

COPY --from=builder /app/video-lucu /video-lucu
EXPOSE 8080
CMD ["/video-lucu"]
