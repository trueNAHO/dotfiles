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

  config = lib.mkIf config.modules.stylix.enable {
    home.activation = {
      ${module} =
        import
        ../../lib/modules/nixos_requirement {
          inherit lib;

          literalExpression = "programs.dconf.enable = true;";
          src = module;
        };
    };

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

        sizes = {
          terminal = 7;
        };
      };

      image = pkgs.fetchurl {
        url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
        sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
      };

      polarity = "dark";
    };
  };
}
