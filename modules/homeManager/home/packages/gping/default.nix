{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.gping.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.gping";

  config = lib.mkIf config.modules.homeManager.home.packages.gping.enable {
    home.packages = [pkgs.gping];
  };
}
