{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.programs.gpg.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.gpg";

  config = lib.mkIf config.dotfiles.homeManager.programs.gpg.enable {
    programs.gpg.enable = true;
  };
}
