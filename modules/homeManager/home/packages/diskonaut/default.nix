{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.diskonaut.enable =
    lib.mkEnableOption "diskonaut";

  config = lib.mkIf config.modules.homeManager.home.packages.diskonaut.enable {
    home.packages = [pkgs.diskonaut];
  };
}
