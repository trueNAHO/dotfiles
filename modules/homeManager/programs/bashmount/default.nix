{
  config,
  lib,
  ...
}: let
  module = "modules.homeManager.programs.bashmount";
in {
  options.modules.homeManager.programs.bashmount.enable =
    lib.mkEnableOption module;

  config = lib.mkIf config.modules.homeManager.programs.bashmount.enable {
    home.activation = {
      ${module} =
        lib.dotfiles.lib.hm.dag.entryBefore.writeBoundary.systemRequirement
        module
        "services.udisks2.enable = true;"
        "https://nix-community.github.io/home-manager/options.xhtml#opt-services.udiskie.enable";
    };

    programs.bashmount.enable = true;
  };
}
