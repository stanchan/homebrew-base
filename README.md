# Homebrew Teleport

A repository for teleport brews.

## Requirements

* [Homebrew](https://github.com/Homebrew/brew)
* Mojave. Untested everywhere else.

## Installation

Run the following in your command-line:

```sh
$ brew tap stanchan/base
$ brew install stanchan/base/teleport
$ brew install stanchan/base/sshpass
$ brew install stanchan/base/mermaid-cli
```

## Bugs happen

The more information you provide and the more detailed your report is, the easier it is for us to fix it.

Please refer to [this section](#filing-bug-reports) for more information.

## Common Issues

Bugs inevitably happen - none of us are running EVERY conceivable setup - but hopefully the install process can be made smoother through the following tips:

- If you have recently upgraded your macOS version or Xcode, read [this section](#common-upgrade-issues).
- Upgrade your macOS to the latest patch version. So if you are on `10.14.0`, upgrade to `10.14.1` etc.
- Ensure Xcode is installed and up to date.
- Run `brew update`. If you tapped an old version of `homebrew-php` or have an old brew installation, this may cause some installation issues.
- Run `brew upgrade`. This will upgrade all installed formulae. Sometimes an old version of a formula is installed and this breaks our dependency management. Unfortunately, there is currently no way to force Homebrew to upgrade only those we depend upon. This is a possible fix for those with `libxml` related compilation issues.
- Run `brew doctor` and fix any issues you can.
- If you upgraded to Mojave `10.14.x`, please also upgrade to the latest Xcode, 10.3.
- File an awesome bug report, using the information in the next section.

Doing all of these might be a hassle, but will more than likely ensure you either have a working install or get help as soon as possible.

## Common upgrade issues

If you have recently upgraded your macOS version or Xcode, you may have some compilation or missing libraries issues. The following information may help you solve most of the problems:

- Ensure you have properly upgraded Command Line Tools depending on your Xcode version.
- Sometimes it appears that a formula is not available anymore, do the following: `brew tap --repair`.

### Filing Bug Reports

## Contributing

See [Contributing](CONTRIBUTING.md)

## Todo

- [ ] Update instructions.

## License

See [LICENSE](LICENSE).