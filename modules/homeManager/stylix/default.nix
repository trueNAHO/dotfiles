{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.stylix.enable = lib.mkEnableOption "Stylix";

  config = lib.mkIf config.modules.homeManager.stylix.enable {
    stylix = {
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
      };

      image = pkgs.fetchurl {
        url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
        sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
      };

      polarity = "dark";
    };
  };
}
