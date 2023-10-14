{
  config,
  lib,
  ...
}: {
  options.modules.programs.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf config.modules.programs.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
