fonts=(swampland Bloody Big Isometric1 Poison Sub-Zero future 3d rusto)

for font in ${fonts[*]}
do
	echo "$font.flf"
	toilet -d ~/.config/scripts/figlet-fonts -f "$font.flf" $1
done
