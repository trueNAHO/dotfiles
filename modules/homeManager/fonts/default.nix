{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.fonts.enable =
    lib.mkEnableOption "modules.homeManager.fonts";

  config = lib.mkIf config.modules.homeManager.fonts.enable {
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
