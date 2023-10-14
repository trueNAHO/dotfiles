{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home.packages.fd.enable = lib.mkEnableOption "fd";

  config = lib.mkIf config.modules.home.packages.fd.enable {
    home.packages = [pkgs.fd];
  };
}
