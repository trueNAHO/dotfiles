{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.fonts.enable =
    lib.mkEnableOption "modules.homeManager.fonts";

  config = lib.mkIf config.modules.homeManager.fonts.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      crimson
      (nerdfonts.override {fonts = ["FiraCode"];})
      ibm-plex
    ];

    # TODO: Use Home Manager's 'fonts.fontconfig.defaultFonts' options inspired
    # by those from NixOS.
    #
    # Requires: https://github.com/nix-community/home-manager/pull/2732
    xdg.configFile."fontconfig/conf.d/52-hm-default-fonts.conf".text = let
      genDefault = fonts: name: let
        prefer = builtins.concatStringsSep "" (
          map (font: "<family>${font}</family>") fonts
        );
      in
        lib.optionalString (fonts != []) ''
          <alias binding="same">
            <family>${name}</family>
            <prefer>
            ${prefer}
            </prefer>
          </alias>
        '';
    in ''
      <?xml version='1.0'?>

      <!-- Generated by Home Manager. -->

      <!DOCTYPE fontconfig SYSTEM 'urn:fontconfig:fonts.dtd'>
      <fontconfig>
        <!-- Default fonts -->
        ${genDefault ["Crimson"] "serif"}
        ${genDefault ["FiraCodeNerdFont"] "monospace"}
        ${genDefault ["IBMPlexSans"] "sans-serif"}
      </fontconfig>
    '';
  };
}
