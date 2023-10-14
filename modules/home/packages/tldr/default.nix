{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home.packages.tldr.enable = lib.mkEnableOption "tldr";

  config = lib.mkIf config.modules.home.packages.tldr.enable {
    home.packages = [pkgs.tldr];
  };
}
