{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.advcpmv.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.advcpmv";

  config = lib.mkIf config.modules.homeManager.home.packages.advcpmv.enable {
    home = {
      packages = [pkgs.advcpmv];

      shellAliases = {
        cp = "advcp --progress-bar";
        mv = "advmv --progress-bar";
      };
    };
  };
}
