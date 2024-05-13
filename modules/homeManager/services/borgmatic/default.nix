{
  config,
  lib,
  ...
}: {
  imports = [../../programs/borgmatic];

  options.dotfiles.homeManager.services.borgmatic.enable =
    lib.mkEnableOption "dotfiles.homeManager.services.borgmatic";

  config = lib.mkIf config.dotfiles.homeManager.services.borgmatic.enable {
    dotfiles.homeManager.programs.borgmatic.enable = true;
    services.borgmatic.enable = true;
  };
}
