{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home.packages.glow.enable = lib.mkEnableOption "glow";

  config = lib.mkIf config.modules.home.packages.glow.enable {
    home.packages = [pkgs.glow];
  };
}
