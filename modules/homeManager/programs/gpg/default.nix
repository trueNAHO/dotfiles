{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.gpg.enable = lib.mkEnableOption "gpg";

  config = lib.mkIf config.modules.homeManager.programs.gpg.enable {
    programs.gpg.enable = true;
  };
}
