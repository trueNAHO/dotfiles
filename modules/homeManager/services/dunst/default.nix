{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.services.dunst.enable =
    lib.mkEnableOption "modules.homeManager.services.dunst";

  config = lib.mkIf config.modules.homeManager.services.dunst.enable {
    services.dunst.enable = true;
  };
}
