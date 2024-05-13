{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.programs.zoxide.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.zoxide";

  config = lib.mkIf config.dotfiles.homeManager.programs.zoxide.enable {
    programs.zoxide.enable = true;
  };
}
