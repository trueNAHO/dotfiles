{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.neofetch.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.neofetch";

  config = lib.mkIf config.modules.homeManager.home.packages.neofetch.enable {
    home.packages = [pkgs.neofetch];
  };
}
