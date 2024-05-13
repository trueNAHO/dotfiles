{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.gcc.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.gcc";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.gcc.enable {
    home.packages = [pkgs.gcc];
  };
}
