{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.rofi = {
    enable = lib.mkEnableOption "rofi";
    pass.enable = lib.mkEnableOption "rofi.pass";
  };

  config = let
    cfg = config.modules.homeManager.programs.rofi;
  in
    lib.mkIf (cfg.enable || cfg.pass.enable) {
      programs.rofi = {
        enable = cfg.enable;
        package = pkgs.rofi-wayland;

        pass = {
          enable = cfg.pass.enable;
          package = pkgs.rofi-pass-wayland;
        };
      };
    };
}
