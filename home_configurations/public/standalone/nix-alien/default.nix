lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "nix-alien" {
  config.modules.nix-alien.enable = true;
  imports = [../../../../modules/nix-alien];
}
