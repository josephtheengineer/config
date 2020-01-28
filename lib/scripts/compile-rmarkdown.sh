pandoc --verbose +RTS -K512m -RTS $1.rmd --to latex --from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash --output $1.tex --highlight-style tango --pdf-engine xelatex --variable graphics=yes --variable 'geometry:margin=1in' --variable 'compact-title:yes' --include-in-header header.tex --include-before-body doc_prefix.tex && tectonic $1.tex

# --include-in-header /nix/store/li98kmw07xh3snjbja5bfnsr491nr2yn-r-rmarkdown-1.18/library/rmarkdown/rmd/latex/compact-title.tex
