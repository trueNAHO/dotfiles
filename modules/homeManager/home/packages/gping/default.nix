{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.gping.enable =
    lib.mkEnableOption "gping";

  config = lib.mkIf config.modules.homeManager.home.packages.gping.enable {
    home.packages = [pkgs.gping];
  };
}
