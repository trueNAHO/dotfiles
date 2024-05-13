{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.p7zip.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.p7zip";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.p7zip.enable {
    home.packages = [pkgs.p7zip];
  };
}
