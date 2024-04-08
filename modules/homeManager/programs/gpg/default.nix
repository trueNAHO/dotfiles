{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.gpg.enable =
    lib.mkEnableOption "modules.homeManager.programs.gpg";

  config = lib.mkIf config.modules.homeManager.programs.gpg.enable {
    programs.gpg.enable = true;
  };
}
