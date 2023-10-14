{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home.packages.tokei.enable = lib.mkEnableOption "tokei";

  config = lib.mkIf config.modules.home.packages.tokei.enable {
    home.packages = [pkgs.tokei];
  };
}
