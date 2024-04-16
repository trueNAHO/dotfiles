{
  lib,
  system,
}:
lib.dotfiles.homeManagerConfiguration.prependPrefix system [./private ./public]
