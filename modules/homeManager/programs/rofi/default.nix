{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../password-store];

  options.modules.homeManager.programs.rofi = {
    enable = lib.mkEnableOption "modules.homeManager.programs.rofi";
    pass.enable = lib.mkEnableOption "modules.homeManager.programs.rofi.pass";
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

        theme = let
          padding = let
            padding = {
              element = 5;
              inputbar = padding.element * 2;
            };
          in {
            element = "${toString padding.element}px";
            inputbar = "${toString padding.inputbar}px";
          };
        in {
          element = {
            padding = padding.element;
            spacing = padding.element;
          };

          inputbar = {
            children = ["prompt" "entry"];
            padding = "${padding.inputbar} ${padding.inputbar}";
            spacing = padding.inputbar;
          };

          window.width = "25%";
        };
      };
    };
}
