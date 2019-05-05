/nix/store/rl8qkygb7pfk037ricp6m7swlvmc5js3-system-path/bin/bash

FOO=`ls`
WORDTOREMOVE="Desktop"

printf '%s\n' "${FOO//$WORDTOREMOVE/}"

#ls -I {Desktop,workspace}
