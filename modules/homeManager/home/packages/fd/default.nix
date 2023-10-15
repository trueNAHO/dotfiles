{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.fd.enable = lib.mkEnableOption "fd";

  config = lib.mkIf config.modules.homeManager.home.packages.fd.enable {
    home.packages = [pkgs.fd];
  };
}
