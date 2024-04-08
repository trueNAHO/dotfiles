{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.fd.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.fd";

  config = lib.mkIf config.modules.homeManager.home.packages.fd.enable {
    home.packages = [pkgs.fd];
  };
}
