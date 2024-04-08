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
        import
        ../../../../lib/modules/nixos_requirement {
          inherit lib;

          documentation = "https://nix-community.github.io/home-manager/options.xhtml#opt-services.udiskie.enable";
          literalExpression = "services.udisks2.enable = true;";
          src = module;
        };
    };

    programs.bashmount.enable = true;
  };
}
