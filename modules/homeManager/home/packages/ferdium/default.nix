{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.ferdium.enable =
    lib.mkEnableOption "ferdium";

  config = lib.mkIf config.modules.homeManager.home.packages.ferdium.enable {
    home.packages = [pkgs.ferdium];
  };
}
