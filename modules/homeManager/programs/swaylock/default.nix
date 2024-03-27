{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.swaylock.enable =
    lib.mkEnableOption "swaylock";

  config = lib.mkIf config.modules.homeManager.programs.swaylock.enable {
    home.activation."modules.homeManager.programs.swaylock" =
      import
      ../../../../lib/modules/nixos_requirement {
        inherit lib;

        documentation = "https://nix-community.github.io/home-manager/options.xhtml#opt-programs.swaylock.enable";
        literalExpression = "security.pam.services.swaylock = {};";
        src = "modules.homeManager.programs.swaylock";
      };

    programs.swaylock = {
      enable = true;

      settings = {
        indicator-radius = 100;
        show-failed-attempts = true;
      };
    };
  };
}
