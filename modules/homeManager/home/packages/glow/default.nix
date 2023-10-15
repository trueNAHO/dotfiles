{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.glow.enable =
    lib.mkEnableOption "glow";

  config = lib.mkIf config.modules.homeManager.home.packages.glow.enable {
    home.packages = [pkgs.glow];
  };
}
