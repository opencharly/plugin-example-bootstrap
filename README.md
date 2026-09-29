# plugin-example-bootstrap

The reference **bootstrap-phase** plugin (`verb:examplebootstrap`) — proof that
the kernel invokes a plugin's `OpBootstrap` on the raw project config bytes
*before* config validation and migration.

The plugin declares `Phase=bootstrap`, so the kernel runs its `OpBootstrap`
before the schema gate. This one is a no-op that returns the bytes unchanged: it
proves the bootstrap hook fires at the right time without mutating anything. A
real bootstrap-phase plugin would transform a stale config's bytes here.

## What it provides

| Capability | Surface |
|---|---|
| `verb:examplebootstrap` (phase `bootstrap`) | the `OpBootstrap` hook — invoked with the raw project config bytes |

Bootstrap plugins are **compiled-in only**: no validated config exists yet to
discover an out-of-process source, so the plugin connects in-proc with no config
re-entry. The bootstrap phase has no other consumer today — neither `migrate` nor
`egress` became a bootstrap plugin.

## How to use it

The plugin is invoked by the kernel at load time; it is not an authorable step.
Compose the plugin candy in a project that needs the bootstrap phase:

```yaml
- '@github.com/opencharly/plugin-example-bootstrap/candy/plugin-example-bootstrap:<tag>'
```

## Layout

- `candy/plugin-example-bootstrap/` — the plugin module: `plugin.go` (the
  provider + `NewProvider()`/`NewMeta()` with `Phase: sdk.PhaseBootstrap`),
  `schema/examplebootstrap.cue` (the served declaration surface),
  `cmd/serve/main.go`.
- `charly.yml` — the root project manifest (`discover: candy`).
- `.github/workflows/tag-on-merge.yml` — CalVer tag + `CHANGELOG/` on merge.

## Related

- Owning skill: `/charly-internals:plugin` — the plugin/provider model and
  lifecycle phases. This candy carries no `skill:` entity of its own; the gap is
  tracked in
  [opencharly/opencharly#291](https://github.com/opencharly/opencharly/issues/291).
- [`opencharly/charly`](https://github.com/opencharly/charly) — the charly CLI.
