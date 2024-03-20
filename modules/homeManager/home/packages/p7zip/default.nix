{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.p7zip.enable =
    lib.mkEnableOption "p7zip";

  config = lib.mkIf config.modules.homeManager.home.packages.p7zip.enable {
    home.packages = [pkgs.p7zip];
  };
}
