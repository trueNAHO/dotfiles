{
  config,
  lib,
  ...
}: {
  imports = [../homeManager/services/dunst ../homeManager/services/swayidle];

  options.dotfiles.wayland.enable = lib.mkEnableOption "dotfiles.wayland";

  config = lib.mkIf config.dotfiles.wayland.enable {
    dotfiles.homeManager.services = {
      dunst.enable = true;
      swayidle.enable = true;
    };

    home.sessionVariables = {
      NIXOS_OZONE_WL = 1;
      QT_QPA_PLATFORM = "wayland;xcb";
    };
  };
}
