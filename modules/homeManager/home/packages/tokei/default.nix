{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.tokei.enable =
    lib.mkEnableOption "tokei";

  config = lib.mkIf config.modules.homeManager.home.packages.tokei.enable {
    home.packages = [pkgs.tokei];
  };
}
