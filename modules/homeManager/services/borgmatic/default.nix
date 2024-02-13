{
  config,
  lib,
  ...
}: {
  imports = [../../programs/borgmatic];

  options.modules.homeManager.services.borgmatic.enable =
    lib.mkEnableOption "borgmatic";

  config = lib.mkIf config.modules.homeManager.services.borgmatic.enable {
    modules.homeManager.programs.borgmatic.enable = true;
    services.borgmatic.enable = true;
  };
}
