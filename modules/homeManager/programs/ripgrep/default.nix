{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.programs.ripgrep.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.ripgrep";

  config = lib.mkIf config.dotfiles.homeManager.programs.ripgrep.enable {
    programs.ripgrep.enable = true;
  };
}
