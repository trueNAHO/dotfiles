{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.xdg.enable = lib.mkEnableOption "xdg";

  config = lib.mkIf config.modules.homeManager.xdg.enable {
    xdg.enable = true;
  };
}
