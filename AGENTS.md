# AGENTS.md — plugin-example-bootstrap

Standalone plugin repo for the bootstrap-phase capability
(`verb:examplebootstrap`) — the reference bootstrap-phase plugin (F9). The plugin
is a Go module at `candy/plugin-example-bootstrap/` (module path
`github.com/opencharly/plugin-example-bootstrap/candy/plugin-example-bootstrap`);
the root `charly.yml` only declares `discover: candy` so the repo is a project
and its candy is scanned.

Canonical files:

- `candy/plugin-example-bootstrap/charly.yml` — the
  `plugin-example-bootstrap:` candy entity (`plugin:` block, `plan:` check).
- `candy/plugin-example-bootstrap/plugin.go` — the provider (`NewProvider()` +
  `NewMeta()` with `Phase: sdk.PhaseBootstrap`) and the no-op `OpBootstrap`.
- `candy/plugin-example-bootstrap/schema/examplebootstrap.cue` — the served
  declaration surface.
- `.github/workflows/tag-on-merge.yml` — CalVer tag + `CHANGELOG/` on merge.
- `README.md` — user overview only; never agent guidance.

## Load these skills first (R0)

- `/charly-internals:plugin` — the plugin authoring reference: the `plugin:`
  block, the unified Provider model, lifecycle phases, the per-plugin CUE-schema
  contract, placement. Load before touching the provider or schema.
- `/charly-internals:git-workflow` — before any git/PR action.

## Build / validate / test

- `go build ./...` in `candy/plugin-example-bootstrap/` — compile the plugin
  module.
- `go test ./...` in `candy/plugin-example-bootstrap/` — the plugin's Go tests
  (`schema_serve_test.go`).
- `charly box validate` at the repo root — the structural check (the candy +
  `plugin:` block, CUE schema).
- The merge gate is the **org-wide** `charly/pr-validator` (required check
  `validate / validate`, defined in `opencharly/.github`); this repo has **no**
  per-repo candy gate.

## Modify this repo

- Edit the `plugin-example-bootstrap:` candy entity, the Go source, and
  `schema/examplebootstrap.cue` **together**.
- This plugin is **compiled-in only** (bootstrap plugins have no validated config
  to discover an out-of-process source); do not describe it as out-of-process.

## Landing

- PR-only. Every change lands through a pull request; the org-required
  `charly/pr-validator` validates the diff and body and arms native auto-merge on
  PASS. Direct pushes to `main` are blocked.
- History lives in `CHANGELOG/` (written by `tag-on-merge` at merge time); the PR
  body IS the changelog.
- The authoritative rulebook is the umbrella `AGENTS.md` in
  `opencharly/opencharly` and `charly/AGENTS.md` in the charly repo. Do not
  restate its rules here.
