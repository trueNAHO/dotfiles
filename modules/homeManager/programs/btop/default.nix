{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.programs.btop.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.btop";

  config = lib.mkIf config.dotfiles.homeManager.programs.btop.enable {
    programs.btop.enable = true;
  };
}
