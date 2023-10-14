{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home.packages.duf.enable = lib.mkEnableOption "duf";

  config = lib.mkIf config.modules.home.packages.duf.enable {
    home.packages = [pkgs.duf];
  };
}
