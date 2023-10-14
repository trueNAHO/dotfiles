{
  config,
  lib,
  ...
}: {
  options.modules.services.easyeffects.enable =
    lib.mkEnableOption "easyeffects";

  config = let
    preset = "default";
  in
    lib.mkIf config.modules.services.easyeffects.enable {
      services.easyeffects = {
        enable =
          lib.info
          "Add 'programs.dconf.enable = true;' to the system configuration for easyeffects to work: https://nix-community.github.io/home-manager/options.html#opt-services.easyeffects.enable"
          true;

        preset = preset;
      };

      xdg.configFile."easyeffects/output/${preset}.json".text = ''
        {
          "output": {
            "autogain#0": {
              "bypass": false,
              "input-gain": 0.0,
              "maximum-history": 15,
              "output-gain": 0.0,
              "reference": "Geometric Mean (MSI)",
              "silence-threshold": -70.0,
              "target": -23.0
            },

            "blocklist": [],

            "plugins_order": [
              "autogain#0"
            ]
          }
        }
      '';
    };
}
