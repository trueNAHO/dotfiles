{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.programs.bash.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.bash";

  config = lib.mkIf config.dotfiles.homeManager.programs.bash.enable {
    programs.bash.enable = true;
  };
}
