{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.libreoffice.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.libreoffice";

  config = lib.mkIf config.modules.homeManager.home.packages.libreoffice.enable {
    home.packages = [pkgs.libreoffice];
  };
}
