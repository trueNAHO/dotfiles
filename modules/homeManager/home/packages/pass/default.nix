{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.pass.enable =
    lib.mkEnableOption "pass";

  config = lib.mkIf config.modules.homeManager.home.packages.pass.enable {
    home.packages = [pkgs.pass-wayland];
  };
}
