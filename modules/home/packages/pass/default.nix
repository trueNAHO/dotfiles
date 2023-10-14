{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home.packages.pass.enable = lib.mkEnableOption "pass";

  config = lib.mkIf config.modules.home.packages.pass.enable {
    home.packages = [pkgs.pass];
  };
}
