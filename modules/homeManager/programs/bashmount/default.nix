{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.bashmount.enable =
    lib.mkEnableOption "bashmount";

  config = lib.mkIf config.modules.homeManager.programs.bashmount.enable {
    home.activation = let
      src = "modules.homeManager.programs.bashmount";
    in {
      ${src} =
        import
        ../../../../lib/modules/nixos_requirement {
          inherit lib src;

          documentation = "https://nix-community.github.io/home-manager/options.xhtml#opt-services.udiskie.enable";
          literalExpression = "services.udisks2.enable = true;";
        };
    };

    programs.bashmount.enable = true;
  };
}
