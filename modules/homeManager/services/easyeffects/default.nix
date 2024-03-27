{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.services.easyeffects.enable =
    lib.mkEnableOption "easyeffects";

  config = let
    preset = "default";
  in
    lib.mkIf config.modules.homeManager.services.easyeffects.enable {
      home.activation.easyeffects =
        import
        ../../../../lib/modules/lib_hm_dag_entry_after_write_boundary_nixos {
          inherit lib;

          documentation = "https://nix-community.github.io/home-manager/options.xhtml#opt-services.easyeffects.enable";
          literalExpression = "programs.dconf.enable = true;";
          src = "modules.homeManager.services.easyeffects";
        };

      services.easyeffects = {
        inherit preset;
        enable = true;
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
