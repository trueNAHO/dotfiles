{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.du-dust.enable =
    lib.mkEnableOption "du-dust";

  config = lib.mkIf config.modules.homeManager.home.packages.du-dust.enable {
    home.packages = [pkgs.du-dust];
  };
}
