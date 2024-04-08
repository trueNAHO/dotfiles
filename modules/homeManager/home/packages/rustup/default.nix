{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.rustup.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.rustup";

  config = lib.mkIf config.modules.homeManager.home.packages.rustup.enable {
    home.packages = [pkgs.rustup];
  };
}
