nix-env -e '*'
sudo nix-env -e '*'
sudo nixos-rebuild switch --upgrade --repair --keep-going
nix-env --delete-generations old
sudo nixos-rebuild boot
nix-collect-garbage
nix-collect-garbage -d
sudo nix-collect-garbage -d
nix-store --optimise
sudo nix-store --optimise
nix-store --gc --print-dead
