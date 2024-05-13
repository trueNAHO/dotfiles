{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.du-dust.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.du-dust";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.du-dust.enable {
    home.packages = [pkgs.du-dust];
  };
}
