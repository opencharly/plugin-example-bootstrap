# plugin-example-bootstrap

The `plugin-example-bootstrap` plugin candy of the [opencharly/charly](https://github.com/opencharly/charly)
candy library, as a standalone repo (the candy de-submodule cutover, plugin
kind). The Go module lives at `candy/plugin-example-bootstrap/` with module path
`github.com/opencharly/plugin-example-bootstrap/candy/plugin-example-bootstrap`; the charly resolver fetches this repo at the pinned tag and
the compiled-in wiring imports the module at that path.
