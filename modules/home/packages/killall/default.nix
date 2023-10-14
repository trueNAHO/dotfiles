{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home.packages.killall.enable = lib.mkEnableOption "killall";

  config = lib.mkIf config.modules.home.packages.killall.enable {
    home.packages = [pkgs.killall];
  };
}
