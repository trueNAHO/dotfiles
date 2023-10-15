{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.services.gammastep.enable =
    lib.mkEnableOption "gammastep";

  config = lib.mkIf config.modules.homeManager.services.gammastep.enable {
    services.gammastep = {
      enable = true;
      latitude = 50.0;
      longitude = 6.0;
    };
  };
}
