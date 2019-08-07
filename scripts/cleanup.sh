nix-env -e '*'
update
nix-collect-garbage -d
nix-store --optimise
