{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.poppler_utils.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.poppler_utils";

  config =
    lib.mkIf
    config.modules.homeManager.home.packages.poppler_utils.enable {
      home.packages = [pkgs.poppler_utils];
    };
}
