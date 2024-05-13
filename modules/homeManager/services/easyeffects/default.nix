{
  config,
  lib,
  ...
}: let
  module = "dotfiles.homeManager.services.easyeffects";
in {
  options.dotfiles.homeManager.services.easyeffects.enable =
    lib.mkEnableOption module;

  config = let
    preset = "default";
  in
    lib.mkIf config.dotfiles.homeManager.services.easyeffects.enable {
      home.activation.${module} =
        lib.dotfiles.lib.hm.dag.entryBefore.writeBoundary.systemRequirement
        module
        "programs.dconf.enable = true;"
        "https://nix-community.github.io/home-manager/options.xhtml#opt-services.easyeffects.enable";

      services.easyeffects = {
        inherit preset;
        enable = true;
      };

      # TODO: Add upstream option for declaring presets.
      xdg.configFile."easyeffects/output/${preset}.json".text =
        builtins.toJSON
        {
          output = let
            autogain = "autogain#0";
          in {
            ${autogain} = {
              bypass = false;
              input-gain = 0;
              maximum-history = 15;
              output-gain = 0;
              reference = "Geometric Mean (MSI)";
              silence-threshold = -70;
              target = -23;
            };

            blocklist = [];
            plugins_order = [autogain];
          };
        };
    };
}
