lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "wayland" {
  config.modules.wayland.enable = true;
  imports = [../../../../modules/wayland];
}
