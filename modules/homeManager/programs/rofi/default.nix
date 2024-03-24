{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../password-store];

  options.modules.homeManager.programs.rofi = {
    enable = lib.mkEnableOption "rofi";
    pass.enable = lib.mkEnableOption "rofi.pass";
  };

  config = let
    cfg = config.modules.homeManager.programs.rofi;
  in
    lib.mkIf (cfg.enable || cfg.pass.enable) {
      modules.homeManager.programs.password-store.enable = true;

      programs.rofi = {
        enable = cfg.enable;
        package = pkgs.rofi-wayland;

        pass = {
          enable = cfg.pass.enable;
          package = pkgs.rofi-pass-wayland;
        };

        theme = {
          element = let
            padding = "5px";
          in {
            inherit padding;
            spacing = padding;
          };

          inputbar = let
            padding = "10px";
          in {
            children = ["prompt" "entry"];
            padding = "${padding} ${padding}";
            spacing = padding;
          };

          window.width = "25%";
        };
      };
    };
}
