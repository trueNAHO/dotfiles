{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.swaylock.enable =
    lib.mkEnableOption "swaylock";

  config = lib.mkIf config.modules.homeManager.programs.swaylock.enable {
    programs.swaylock = {
      enable =
        import ../../../../lib/modules/lib_info_nixos {
          inherit lib;

          documentation = "https://nix-community.github.io/home-manager/options.xhtml#opt-programs.swaylock.enable";
          literalExpression = "security.pam.services.swaylock = {};";
          src = "modules.homeManager.programs.swaylock";
        }
        true;

      settings = {
        indicator-radius = 100;
        show-failed-attempts = true;
      };
    };
  };
}
