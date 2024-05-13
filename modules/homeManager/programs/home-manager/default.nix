{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.programs.home-manager.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.home-manager";

  config = lib.mkIf config.dotfiles.homeManager.programs.home-manager.enable {
    programs.home-manager.enable = true;
  };
}
