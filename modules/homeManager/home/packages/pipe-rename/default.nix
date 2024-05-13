{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.pipe-rename.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.pipe-rename";

  config =
    lib.mkIf
    config.dotfiles.homeManager.home.packages.pipe-rename.enable {
      home.packages = [pkgs.pipe-rename];
    };
}
