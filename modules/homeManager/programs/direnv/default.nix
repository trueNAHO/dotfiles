{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.programs.direnv.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.direnv";

  config = lib.mkIf config.dotfiles.homeManager.programs.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
