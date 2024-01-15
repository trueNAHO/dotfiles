{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.libreoffice.enable =
    lib.mkEnableOption "libreoffice";

  config = lib.mkIf config.modules.homeManager.home.packages.libreoffice.enable {
    home.packages = [pkgs.libreoffice];
  };
}
