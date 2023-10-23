{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.services.easyeffects.enable =
    lib.mkEnableOption "easyeffects";

  config = let
    preset = "default";
  in
    lib.mkIf config.modules.homeManager.services.easyeffects.enable {
      services.easyeffects = {
        enable =
          lib.info
          "Add 'programs.dconf.enable = true;' to the system configuration for ${pkgs.easyeffects.pname} to work: https://nix-community.github.io/home-manager/options.html#opt-services.easyeffects.enable"
          true;

        preset = preset;
      };

      xdg.configFile."easyeffects/output/${preset}.json".text = builtins.toJSON {
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
