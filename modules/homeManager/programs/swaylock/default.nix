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
    home.activation.${module} =
      lib.dotfiles.lib.hm.dag.entryBefore.writeBoundary.systemRequirement
      module
      "security.pam.services.swaylock = {};"
      "https://nix-community.github.io/home-manager/options.xhtml#opt-programs.swaylock.enable";

    programs.swaylock = {
      enable = true;

      settings = {
        indicator-radius = 100;
        show-failed-attempts = true;
      };
    };
  };
}
