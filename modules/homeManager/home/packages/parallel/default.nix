{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.parallel.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.parallel";

  config = lib.mkIf config.modules.homeManager.home.packages.parallel.enable {
    home.packages = [(pkgs.parallel-full.override {willCite = true;})];
  };
}
