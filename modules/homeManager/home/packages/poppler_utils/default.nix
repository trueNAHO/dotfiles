{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.poppler_utils.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.poppler_utils";

  config =
    lib.mkIf
    config.dotfiles.homeManager.home.packages.poppler_utils.enable {
      home.packages = [pkgs.poppler_utils];
    };
}
