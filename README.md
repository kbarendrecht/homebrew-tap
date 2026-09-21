# homebrew-tap

A Homebrew tap for [Orchestrator](https://github.com/kbarendrecht/orchestrator).

```sh
brew install --cask kbarendrecht/tap/orchestrator
```

That installs `Orchestrator.app` and puts `orch` on your `PATH`. Apple Silicon
only.

Upgrade with `brew upgrade --cask orchestrator`, and remove with
`brew uninstall --cask orchestrator` (add `--zap` to take the daemon's state
with it).

## How the cask is kept current

`.github/workflows/bump.yml` reads the newest release of the app, rewrites the
version and the sum in `Casks/orchestrator.rb`, and then **installs what it just
published** on a macOS runner. It runs daily, and `mise run release` dispatches
it so a release is in the tap within a minute rather than a day.
