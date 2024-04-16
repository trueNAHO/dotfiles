lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "hyprland" {
  config.modules.homeManager.wayland.windowManager.hyprland.enable = true;

  imports = [
    ../../../../../../../modules/homeManager/wayland/windowManager/hyprland
  ];
}
