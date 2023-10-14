{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home.packages.du-dust.enable = lib.mkEnableOption "du-dust";

  config = lib.mkIf config.modules.home.packages.du-dust.enable {
    home.packages = [pkgs.du-dust];
  };
}
