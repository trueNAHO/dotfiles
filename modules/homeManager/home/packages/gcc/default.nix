{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.gcc.enable =
    lib.mkEnableOption "gcc";

  config = lib.mkIf config.modules.homeManager.home.packages.gcc.enable {
    home.packages = [pkgs.gcc];
  };
}
