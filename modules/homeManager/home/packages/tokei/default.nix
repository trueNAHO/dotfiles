{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.tokei.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.tokei";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.tokei.enable {
    home.packages = [pkgs.tokei];
  };
}
