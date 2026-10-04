# TOFIX

Findings from a code scan on 2026-10-04.

## Medium

- `rsconstruct.toml:14-17` - the only build step renders `src/*.txt` with `a2x -f pdf`, which goes through DocBook and ignores the `:backend: slidy` header at `src/example.txt:4`, so the repo never produces the Slidy HTML slideshow it exists to demo; render with `asciidoc --backend slidy` (HTML output) instead of, or in addition to, the PDF.

## Low

- `src/example.txt:10-12` - says the command creates `slidy.html` from `slidy.txt`, but the file is `example.txt`; line 30 likewise names `slidy-example.txt`. Update the commands to the real file name.
- `src/example.txt:62` - typo "at at time"; and `src/example.txt:75` "not define" should be "not defined".
- `src/example.txt:24` - plain `http://www.w3.org/Talks/Tools/Slidy2/` link; switch to `https://`.
- `README.md:2` - one-line README does not say how to build or view the demo (which tool, where output lands); add a short usage note.
