{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home.packages.entr.enable = lib.mkEnableOption "entr";

  config = lib.mkIf config.modules.home.packages.entr.enable {
    home.packages = [pkgs.entr];
  };
}
