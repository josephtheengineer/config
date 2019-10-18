echo "" > ~/.config/scripts/vars.sh

echo "export PLAN9=$(find /nix/store -name plan9 | head -1)" >> ~/.config/scripts/vars.sh
