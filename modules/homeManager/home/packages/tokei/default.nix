{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.tokei.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.tokei";

  config = lib.mkIf config.modules.homeManager.home.packages.tokei.enable {
    home.packages = [pkgs.tokei];
  };
}
