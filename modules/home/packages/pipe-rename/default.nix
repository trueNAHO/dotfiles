{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.home.packages.pipe-rename.enable =
    lib.mkEnableOption "pipe-rename";

  config = lib.mkIf config.modules.home.packages.pipe-rename.enable {
    home.packages = [pkgs.pipe-rename];
  };
}
