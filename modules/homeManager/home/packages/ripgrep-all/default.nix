{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.ripgrep-all.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.ripgrep-all";

  config =
    lib.mkIf
    config.dotfiles.homeManager.home.packages.ripgrep-all.enable {
      home.packages = [pkgs.ripgrep-all];
    };
}
