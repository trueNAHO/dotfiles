{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.tldr.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.tldr";

  config = lib.mkIf config.modules.homeManager.home.packages.tldr.enable {
    home.packages = [pkgs.tldr];
  };
}
