{
  config,
  lib,
  ...
}: let
  module = "modules.homeManager.services.easyeffects";
in {
  options.modules.homeManager.services.easyeffects.enable =
    lib.mkEnableOption module;

  config = let
    preset = "default";
  in
    lib.mkIf config.modules.homeManager.services.easyeffects.enable {
      home.activation = {
        ${module} =
          import
          ../../../../lib/modules/nixos_requirement {
            inherit lib;

            documentation = "https://nix-community.github.io/home-manager/options.xhtml#opt-services.easyeffects.enable";
            literalExpression = "programs.dconf.enable = true;";
            src = module;
          };
      };

      services.easyeffects = {
        inherit preset;
        enable = true;
      };

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
