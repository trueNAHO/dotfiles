{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.alacritty.enable =
    lib.mkEnableOption "alacritty";

  config = lib.mkIf config.modules.homeManager.programs.alacritty.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        font.size = lib.mkForce 7;

        key_bindings = [
          {
            key = "Key0";
            mods = "Alt";
            action = "ResetFontSize";
          }

          {
            key = "Minus";
            mods = "Alt";
            action = "DecreaseFontSize";
          }

          {
            key = "Equals";
            mods = "Alt";
            action = "IncreaseFontSize";
          }
        ];

        window.padding = {
          x = 2;
          y = 2;
        };
      };
    };
  };
}
