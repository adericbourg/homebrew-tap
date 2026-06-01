# adericbourg/tap

A personal [Homebrew](https://brew.sh) tap by [@adericbourg](https://github.com/adericbourg).

## Usage

### Add this tap

```sh
brew tap adericbourg/tap
```

### Install a formula

```sh
brew install adericbourg/tap/<formula>
```

Or in a single step, without adding the tap first:

```sh
brew install adericbourg/tap/<formula>
```

## Available formulae

> No formulae have been published yet. Check back later.

| Formula | Description | Install |
|---------|-------------|---------|
| _(none yet)_ | | |

## Repository layout

```
homebrew-tap/
├── Formula/   # Ruby formula files (<formula>.rb)
└── Casks/     # Optional: macOS app casks (<cask>.rb)
```

Homebrew discovers formulae automatically by scanning `Formula/*.rb`.

## Adding a new formula

1. Create `Formula/<name>.rb` following the [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook).
2. Run `brew install --build-from-source Formula/<name>.rb` to test locally.
3. Run `brew audit --strict --new <name>` and fix any warnings.
4. Run `brew test <name>` to verify the installed formula passes its test block.

## License

MIT — see [LICENSE](LICENSE).
