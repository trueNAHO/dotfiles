{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home.packages.wl-clipboard.enable =
    lib.mkEnableOption "wl-clipboard";

  config = lib.mkIf config.modules.home.packages.wl-clipboard.enable {
    home.packages = [pkgs.wl-clipboard];
  };
}
