{
  config,
  lib,
  ...
}: {
  imports = [../homeManager/services/dunst ../homeManager/services/swayidle];

  options.modules.wayland.enable = lib.mkEnableOption "modules.wayland";

  config = lib.mkIf config.modules.wayland.enable {
    modules.homeManager.services = {
      dunst.enable = true;
      swayidle.enable = true;
    };

    home.sessionVariables = {
      NIXOS_OZONE_WL = 1;
      QT_QPA_PLATFORM = "wayland;xcb";
    };
  };
}
