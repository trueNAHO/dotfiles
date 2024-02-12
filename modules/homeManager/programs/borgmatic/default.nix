{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.borgmatic.enable =
    lib.mkEnableOption "borgmatic";

  config = lib.mkIf config.modules.homeManager.programs.borgmatic.enable {
    programs.borgmatic.enable = true;
  };
}
