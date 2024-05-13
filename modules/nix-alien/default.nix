{
  config,
  inputs,
  lib,
  system,
  ...
}: {
  options.dotfiles.nix-alien.enable = lib.mkEnableOption "dotfiles.nix-alien";

  config = lib.mkIf config.dotfiles.nix-alien.enable {
    home.packages = [inputs.nix-alien.packages.${system}.nix-alien];
  };
}
