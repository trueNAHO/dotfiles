{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.grim.enable =
    lib.mkEnableOption "grim";

  config = lib.mkIf config.modules.homeManager.home.packages.grim.enable {
    home.packages = [pkgs.grim];
  };
}
