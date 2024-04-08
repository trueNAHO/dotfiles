{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.ripgrep-all.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.ripgrep-all";

  config = lib.mkIf config.modules.homeManager.home.packages.ripgrep-all.enable {
    home.packages = [pkgs.ripgrep-all];
  };
}
