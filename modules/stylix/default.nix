{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  module = "modules.stylix";
in {
  imports = [inputs.stylix.homeManagerModules.stylix];
  options.modules.stylix.enable = lib.mkEnableOption module;

  config = lib.mkMerge [
    # TODO: Patch an upstream 'stylix.enable' option [1] to merge the
    # unconditional 'stylix.image' option with the conditional 'lib.mkIf
    # config.modules.stylix.enable' attribute set.
    #
    # [1]: https://github.com/danth/stylix/issues/216
    {
      stylix.image = pkgs.fetchurl {
        url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
        sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
      };
    }

    (
      lib.mkIf config.modules.stylix.enable {
        home.activation.${module} =
          lib.dotfiles.lib.hm.dag.entryBefore.writeBoundary.systemRequirement
          module
          "programs.dconf.enable = true;"
          "";

        stylix = {
          cursor = {
            name = "Bibata-Modern-Amber";
            package = pkgs.bibata-cursors;
            size = 22;
          };

          fonts = {
            emoji = {
              package = pkgs.noto-fonts-emoji;
              name = "Noto Color Emoji";
            };

            monospace = {
              package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
              name = "FiraCodeNerdFont";
            };

            sansSerif = {
              package = pkgs.ibm-plex;
              name = "IBMPlexSans";
            };

            serif = {
              package = pkgs.crimson;
              name = "Crimson";
            };

            sizes.terminal = 7;
          };

          polarity = "dark";
        };
      }
    )
  ];
}
