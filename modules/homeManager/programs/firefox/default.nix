{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.programs.firefox.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.firefox";

  config = lib.mkIf config.dotfiles.homeManager.programs.firefox.enable {
    programs.firefox.enable = true;
  };
}
