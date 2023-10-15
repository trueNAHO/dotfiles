{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.entr.enable =
    lib.mkEnableOption "entr";

  config = lib.mkIf config.modules.homeManager.home.packages.entr.enable {
    home.packages = [pkgs.entr];
  };
}
