{lib, ...}: let
  preset = "default";
in {
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
}
