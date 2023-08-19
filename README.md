<h1 align="center">
  Dotfiles
</h1>

<p align="center">
  <a href="https://github.com/trueNAHO/dotfiles/stargazers"
    ><img
      src="https://img.shields.io/github/stars/trueNAHO/dotfiles?colorA=363a4f&colorB=b7bdf8&style=for-the-badge"
      alt="Stars: N/A"
  /></a>
  <a href="https://github.com/trueNAHO/dotfiles/issues"
    ><img
      src="https://img.shields.io/github/issues/trueNAHO/dotfiles?colorA=363a4f&colorB=f5a97f&style=for-the-badge"
      alt="Issues: N/A"
  /></a>
  <a href="https://github.com/trueNAHO/dotfiles/contributors"
    ><img
      src="https://img.shields.io/github/contributors/trueNAHO/dotfiles?colorA=363a4f&colorB=a6da95&style=for-the-badge"
      alt="Issues: N/A"
  /></a>
</p>

- [Installation](#installation)
  - [Installing dotfiles without an existing chezmoi installation](#installing-dotfiles-without-an-existing-chezmoi-installation)
  - [Installing dotfiles with an existing chezmoi installation](#installing-dotfiles-with-an-existing-chezmoi-installation)
- [See Also](#see-also)
- [Contributing](#contributing)
- [License](#license)

## Installation

Packages are installed either system-wide or in the home directory depending on
the values of the `IS_INSTALL_PACKAGES` and `IS_INSTALL_LOCALLY` [chezmoi
configurations](docs/chezmoi.yaml), and the availability of package managers and
sudo access. If the `IS_INSTALL_PACKAGES` variable is set to true, the packages
will be installed, otherwise, they will be skipped. If `IS_INSTALL_LOCALLY` is
false, and a supported package manager is found with sudo access, the packages
will be installed system-wide using that package manager. If
`IS_INSTALL_LOCALLY` is true, the packages will be installed in the home
directory using the [JuNest](https://github.com/fsquillace/junest) tool if it is
available, otherwise [JuNest](https://github.com/fsquillace/junest) will be
installed first. If `IS_INSTALL_LOCALLY` is false, no supported package manager
is found, and sudo access is not available, an error message will be printed to
standard error.

The internal [JuNest](https://github.com/fsquillace/junest) installation
requires the `curl`, `git`, and `wget` utilities. For more information on
customizing the internal installation variables, refer to the [example
configuration file](docs/chezmoi.yaml) for [chezmoi](https://chezmoi.io), which
includes all the default values.

### Installing dotfiles without an existing [chezmoi](https://chezmoi.io) installation

If [chezmoi](https://chezmoi.io) is not installed on the system, use the
following command to install [chezmoi](https://chezmoi.io) and all dotfiles from
this repository:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/trueNAHO/dotfiles.git
```

[Alternatively](https://www.chezmoi.io/reference/commands/init/#-one-shot), use
the following command to install all dotfiles from this repository without
[chezmoi](https://chezmoi.io). It attempts to install the dotfiles with
[chezmoi](https://chezmoi.io) and then remove all traces of
[chezmoi](https://chezmoi.io) from the system, which can be useful for setting
up temporary environments such as Docker containers:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --one-shot https://github.com/trueNAHO/dotfiles.git
```

### Installing dotfiles with an existing [chezmoi](https://chezmoi.io) installation

If [chezmoi](https://chezmoi.io) is already installed on the system, use the
following command to install all dotfiles from this repository:

```bash
chezmoi init --apply https://github.com/trueNAHO/dotfiles.git
```

[Alternatively](https://www.chezmoi.io/reference/commands/init/#-purge), use the
following command to install all dotfiles from this repository, and then remove
the source and config directories after applying:

```bash
chezmoi init --apply --purge https://github.com/trueNAHO/dotfiles.git
```

## See Also

- [Commitizen](http://commitizen.github.io/cz-cli)
- [JuNest](https://github.com/fsquillace/junest)
- [chezmoi](https://chezmoi.io)

## Contributing

To contribute, please review [our contribution
guidelines](docs/CONTRIBUTING.md).

## License

This project is licensed under [GNU GENERAL PUBLIC LICENSE Version 3](LICENSE).
