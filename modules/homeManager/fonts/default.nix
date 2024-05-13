{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.fonts.enable =
    lib.mkEnableOption "dotfiles.homeManager.fonts";

  config = lib.mkIf config.dotfiles.homeManager.fonts.enable {
    fonts.fontconfig = {
      defaultFonts = {
        monospace = ["FiraCodeNerdFont"];
        sansSerif = ["IBMPlexSans"];
        serif = ["Crimson"];
      };

      enable = true;
    };

    home.packages = with pkgs; [
      crimson
      (nerdfonts.override {fonts = ["FiraCode"];})
      ibm-plex
    ];
  };
}
