# Use pandoc to convert markdown to latex
pandoc --verbose +RTS -K512m \
	-RTS $1.rmd \
	--to latex \
	--from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash \
	--output $1.tex \
	--highlight-style tango \
	--pdf-engine xelatex \
	--variable graphics=yes \
	--variable 'geometry:margin=1in' \
	--variable 'compact-title:yes' \
	--include-in-header header.tex &&

		# Use tectonic to convert latex to pdf
		tectonic $1.tex
