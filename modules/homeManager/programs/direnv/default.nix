{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.direnv.enable =
    lib.mkEnableOption "direnv";

  config = lib.mkIf config.modules.homeManager.programs.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
