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
      home.file."${config.programs.rofi.configPath}".text = let
        largePadding = toString 10;
        smallPadding = toString 5;
      in ''
        element {
          padding: ${smallPadding}px;
          spacing: ${smallPadding}px;
        }

        inputbar {
          children: [ prompt, entry ];
          padding: ${largePadding}px ${largePadding}px;
          spacing: ${largePadding}px;
        }

        window {
          width: 25%;
        }
      '';

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
