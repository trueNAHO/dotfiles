{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.swaylock.enable =
    lib.mkEnableOption "swaylock";

  config = lib.mkIf config.modules.homeManager.programs.swaylock.enable {
    home.activation = let
      src = "modules.homeManager.programs.swaylock";
    in {
      ${src} =
        import
        ../../../../lib/modules/nixos_requirement {
          inherit lib src;

          documentation = "https://nix-community.github.io/home-manager/options.xhtml#opt-programs.swaylock.enable";
          literalExpression = "security.pam.services.swaylock = {};";
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
