{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.pipe-rename.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.pipe-rename";

  config =
    lib.mkIf
    config.modules.homeManager.home.packages.pipe-rename.enable {
      home.packages = [pkgs.pipe-rename];
    };
}
