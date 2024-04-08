{
  config,
  lib,
  pkgs,
  ...
}: let
  module = "modules.homeManager.programs.mpv";
in {
  imports = [../../../stylix];

  options.modules.homeManager.programs.mpv.enable = lib.mkEnableOption module;

  config = lib.mkIf config.modules.homeManager.programs.mpv.enable {
    modules.stylix.enable = true;

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

    programs.mpv = {
      enable = true;

      scriptOpts = {
        playlistmanager.key_showplaylist = "F8";
        thumbfast.network = "yes";

        uosc = let
          colors = config.lib.stylix.colors;
        in {
          background = colors.base00;
          background_text = colors.base05;
          curtain = colors.base0D;
          error = colors.base0F;
          foreground = colors.base05;
          foreground_text = colors.base00;
          success = colors.base0A;
          top_bar_controls = "no";
        };
      };

      scripts = with pkgs.mpvScripts; [mpv-playlistmanager thumbfast uosc];
    };
  };
}
