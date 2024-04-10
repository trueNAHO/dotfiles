{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.wl-clipboard.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.wl-clipboard";

  config =
    lib.mkIf
    config.modules.homeManager.home.packages.wl-clipboard.enable {
      home.packages = [pkgs.wl-clipboard];
    };
}
