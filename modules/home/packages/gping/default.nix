{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home.packages.gping.enable = lib.mkEnableOption "gping";

  config = lib.mkIf config.modules.home.packages.gping.enable {
    home.packages = [pkgs.gping];
  };
}
