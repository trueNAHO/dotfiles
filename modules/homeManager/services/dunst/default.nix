{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.services.dunst.enable =
    lib.mkEnableOption "dotfiles.homeManager.services.dunst";

  config = lib.mkIf config.dotfiles.homeManager.services.dunst.enable {
    services.dunst.enable = true;
  };
}
