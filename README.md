# homebrew-ofem

Homebrew tap for **OFEM — OneLake File Explorer for macOS**.

## Install

```bash
brew install --cask sdebruyn/ofem/ofem
```

That single command installs `OneLake.app`, registers the background daemon as a LaunchAgent, and puts the `ofem` CLI on your `$PATH`.

## Updates

```bash
brew upgrade --cask ofem
```

## Uninstall

```bash
brew uninstall --cask ofem          # removes OneLake.app, keeps user data
brew uninstall --cask --zap ofem    # also wipes caches, prefs, logs, and ~/OneLake
brew untap sdebruyn/ofem
```

## Source

The cask and formula are produced and pushed here automatically by [goreleaser](https://goreleaser.com/) on each release of [sdebruyn/onelake-explorer-macos](https://github.com/sdebruyn/onelake-explorer-macos). Do not edit them by hand — your change will be overwritten on the next release.

## Documentation

[ofem.debruyn.dev](https://ofem.debruyn.dev)

## License

MIT, same as the parent project.
