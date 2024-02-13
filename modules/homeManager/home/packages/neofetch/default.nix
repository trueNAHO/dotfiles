{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.neofetch.enable =
    lib.mkEnableOption "neofetch";

  config = lib.mkIf config.modules.homeManager.home.packages.neofetch.enable {
    home.packages = [pkgs.neofetch];
  };
}
