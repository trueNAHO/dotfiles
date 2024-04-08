{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.catnip.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.catnip";

  config = lib.mkIf config.modules.homeManager.home.packages.catnip.enable {
    home.packages = [pkgs.catnip];
  };
}
