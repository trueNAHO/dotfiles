{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.programs.fzf.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.fzf";

  config = lib.mkIf config.dotfiles.homeManager.programs.fzf.enable {
    programs.fzf.enable = true;
  };
}
