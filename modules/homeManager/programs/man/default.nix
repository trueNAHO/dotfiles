{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.programs.man.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.man";

  config = lib.mkIf config.dotfiles.homeManager.programs.man.enable {
    programs.man.enable = true;
  };
}
