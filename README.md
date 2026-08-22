# Portless Homebrew Tap

This is the official Homebrew tap for
[Portless](https://github.com/runportless/portless).

## Install

```bash
brew install runportless/tap/portless
portless setup
```

Use the fully qualified formula name because Homebrew Core contains an
unrelated formula named `portless`.

## Upgrade

```bash
brew upgrade runportless/tap/portless
portless setup
```

## Uninstall

```bash
portless uninstall --yes
brew uninstall runportless/tap/portless
```

## Brewfile

```ruby
tap "runportless/tap"
brew "runportless/tap/portless"
```

## Documentation

See the [Portless documentation](https://github.com/runportless/portless#readme)
and [Homebrew documentation](https://docs.brew.sh).
