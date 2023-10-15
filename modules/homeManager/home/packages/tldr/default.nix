{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.tldr.enable =
    lib.mkEnableOption "tldr";

  config = lib.mkIf config.modules.homeManager.home.packages.tldr.enable {
    home.packages = [pkgs.tldr];
  };
}
