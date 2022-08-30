<h1 align="center">
  <a href="https://github.com/jglovier/dotfiles-logo">
    <img
        src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/main/dotfiles-logo.svg"
        alt="Dotfiles"
        width="350"
    >
    </a>
</h1>

<h4 align="center">
  My dotfiles, managed with
      <a href="https://chezmoi.io/" target="_blank">chezmoi</a>.
</h4>

<p align="center">
  <a href="docs/CONTRIBUTING.md">
    <img
        src="https://badgen.net/badge/PRs/welcome"
        alt="PRs are welcome"
    >
  </a>

  <a href="http://commitizen.github.io/cz-cli/">
    <img
        src="https://badgen.net/badge/Commitizen/friendly"
        alt="Commitizen friendly"
    >
  </a>

  <a href="https://badgen.net/github/stars/trueNAHO/dotfiles?cache=0">
    <img
        src="https://badgen.net/github/stars/trueNAHO/dotfiles?cache=0"
        alt="stars: N/A"
    >
  </a>

  <a href="https://badgen.net/github/watchers/trueNAHO/dotfiles?cache=0">
    <img
        src="https://badgen.net/github/watchers/trueNAHO/dotfiles?cache=0"
        alt="watchers: N/A"
    >
  </a>

  <a href="https://badgen.net/github/contributors/trueNAHO/dotfiles?cache=0">
    <img
        src="https://badgen.net/github/contributors/trueNAHO/dotfiles?cache=0"
        alt="contributors: N/A"
    >
  </a>

  <a href="https://badgen.net/github/branches/trueNAHO/dotfiles?cache=0">
    <img
        src="https://badgen.net/github/branches/trueNAHO/dotfiles?cache=0"
        alt="branches: N/A"
    >
  </a>

  <a href="https://badgen.net/github/last-commit/trueNAHO/dotfiles/master?cache=0">
    <img
        src="https://badgen.net/github/last-commit/trueNAHO/dotfiles/master?cache=0"
        alt="last commit: N/A ago"
    >
  </a>

  <a href="https://badgen.net/github/checks/trueNAHO/dotfiles?cache=0">
    <img
        src="https://badgen.net/github/checks/trueNAHO/dotfiles?cache=0"
        alt="checks: N/A"
    >
  </a>

  <a href="https://badgen.net/github/status/trueNAHO/dotfiles?cache=0">
    <img
        src="https://badgen.net/github/status/trueNAHO/dotfiles?cache=0"
        alt="status: N/A"
    >
  </a>

  <a href="docs/CODE_OF_CONDUCT.md">
    <img
        src="https://badgen.net/badge/Contributor%20Convenant/2.1"
        alt="Contributor Convenant 2.1"
    >
  </a>

  <a href="LICENSE">
    <img
        src="https://badgen.net/github/license/trueNAHO/dotfiles"
        alt="license: N/A"
    >
  </a>
</p>

<p align="center">
  <a href="#how-to-use">How to use</a> •
  <a href="#related">Related</a> •
  <a href="#contrbuting">Contributing</a> •
  <a href="#license">License</a>
</p>

# How to use

## [chezmoi](https://chezmoi.io/) is not installed on the system

Install all dotfiles from this GitHub repository on a new, empty machine with a
single command:

```bash
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply --one-shot https://github.com/trueNAHO/dotfiles.git
```

Install all dotfiles **AND [chezmoi](https://chezmoi.io/)** from this GitHub
repository on a new, empty machine with a single command:

```bash
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply https://github.com/trueNAHO/dotfiles.git
```

## [chezmoi](https://chezmoi.io/) is installed on the system

If [chezmoi](https://chezmoi.io/) is already installed on the system and you
want to install all dotfiles from this GitHub repository, then run:

```bash
chezmoi init https://github.com/trueNAHO/dotfiles.git
```

If [chezmoi](https://chezmoi.io/) is already installed on the system and you
want to install all dotfiles from this GitHub repository **AND remove
[chezmoi](https://chezmoi.io/)'s source and config directories after
applying**, then run:

```bash
chezmoi init --purge --force https://github.com/trueNAHO/dotfiles.git
```

# Related

- [Commitizen](http://commitizen.github.io/cz-cli/) - Simple commit conventions
  for internet citizens.
- [chezmoi](https://chezmoi.io/) - Manage your dotfiles across multiple diverse
  machines, securely.
- [pre-commit](https://pre-commit.com/) - A framework for managing and
  maintaining multi-language pre-commit hooks.

# Contributing

Please read [CONTRIBUTING.md](docs/CONTRIBUTING.md) for details on contributing.

# License

This project is licensed under [GNU GENERAL PUBLIC LICENSE Version 3](LICENSE).
