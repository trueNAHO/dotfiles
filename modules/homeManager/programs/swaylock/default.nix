{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.swaylock.enable =
    lib.mkEnableOption "swaylock";

  config = lib.mkIf config.modules.homeManager.programs.swaylock.enable {
    programs.swaylock = {
      enable =
        lib.info
        "Add 'security.pam.services.swaylock = {};' to the system configuration for '${pkgs.swaylock.pname}' to work: https://nix-community.github.io/home-manager/options.html#opt-programs.swaylock.enable"
        true;

      settings = {
        indicator-radius = 100;
        show-failed-attempts = true;
      };
    };
  };
}
