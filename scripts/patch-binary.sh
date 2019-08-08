: 1561956334:0;patchelf --print-interpreter locus-amoenus
: 1561956344:0;rebuild
: 1561956368:0;gotop
: 1561956397:0;nix-env -iA nixos.patchelf
: 1561956428:0;vim /etc/nix/nixpkgs-config.nix
: 1561956451:0;rm -rf vim /etc/nix/nixpkgs-config.nix $1
: 1561956464:0;rm -rf /etc/nix/nixpkgs-config.nix
: 1561956467:0;sudo rm -rf /etc/nix/nixpkgs-config.nix
: 1561956475:0;nix-env -iA nixos.patchelf
: 1561956503:0;patchelf --print-interpreter locus-amoenus
: 1561956506:0;./locus-amoenus
: 1561956556:0;patchelf \\
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \\
      locus-amoenus
: 1561956783:0;nix-env -iA stdenv wget dpkg nix-index
: 1561956799:0;nix-shell -p binutils stdenv wget dpkg nix-index \\
   stdenv.cc
: 1561956847:0;./locus-amoenus
: 1561956850:0;ls
: 1561956856:0;cp locus-amoenus ~/
: 1561956858:0;cd ~/
: 1561956860:0;ls
: 1561956873:0;./locus-amoenus 
: 1561956893:0;./locus-amoenus rms-olympe
