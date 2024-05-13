{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.programs.feh.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.feh";

  config = lib.mkIf config.dotfiles.homeManager.programs.feh.enable {
    programs.feh.enable = true;
  };
}
