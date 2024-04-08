{
  config,
  lib,
  ...
}: let
  module = "modules.homeManager.programs.swaylock";
in {
  options.modules.homeManager.programs.swaylock.enable =
    lib.mkEnableOption module;

  config = lib.mkIf config.modules.homeManager.programs.swaylock.enable {
    home.activation = {
      ${module} =
        import
        ../../../../lib/modules/nixos_requirement {
          inherit lib;

          documentation = "https://nix-community.github.io/home-manager/options.xhtml#opt-programs.swaylock.enable";
          literalExpression = "security.pam.services.swaylock = {};";
          src = module;
        };
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
