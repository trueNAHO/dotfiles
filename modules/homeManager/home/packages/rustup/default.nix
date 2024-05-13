{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.rustup.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.rustup";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.rustup.enable {
    home.packages = [pkgs.rustup];
  };
}
