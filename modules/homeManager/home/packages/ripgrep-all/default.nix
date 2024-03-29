{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.ripgrep-all.enable =
    lib.mkEnableOption "ripgrep-all";

  config = lib.mkIf config.modules.homeManager.home.packages.ripgrep-all.enable {
    home.packages = [pkgs.ripgrep-all];
  };
}
