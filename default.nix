let
  nixpkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz")
  {
    config = { allowUnfree = true; };
  };

  packages = with nixpkgs; [
    go gopls musl gcc
  ];

  mkShell = shellHook: nixpkgs.mkShell {
    name = "video-lucu";
    inherit packages shellHook;
  };
in
  {
    dev = mkShell "";

    restore = mkShell ''
      set -e
      echo "INFO: Spawning bash derivation for restore"
      go get -C ./cmd/video-lucu
      exit
    '';

    build = mkShell ''
      set -e
      echo "INFO: Spawning bash derivation for build"
      go build -C ./cmd/video-lucu -ldflags="-linkmode external -extldflags -static -w -s" -o "../../video-lucu"
      exit
    '';
  }
