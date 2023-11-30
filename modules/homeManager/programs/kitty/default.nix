{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.kitty.enable =
    lib.mkEnableOption "kitty";

  config = lib.mkIf config.modules.homeManager.programs.kitty.enable {
    home.sessionVariables.TERMINAL = pkgs.kitty.pname;

    programs.kitty = {
      enable = true;

      keybindings = let
        change_font_size_value = toString 0.5;
      in {
        "alt+equal" = "change_font_size all 0";
        "alt+minus" = "change_font_size all -${change_font_size_value}";
        "alt+plus" = "change_font_size all +${change_font_size_value}";
        "kitty_mod+c" = "copy_to_clipboard";
        "kitty_mod+v" = "paste_from_clipboard";
      };

      settings = {
        clear_all_shortcuts = true;
        confirm_os_window_close = 0;
        enable_audio_bell = false;
        font_size = 7;
        input_delay = 0;
        window_margin_width = 2;
      };
    };
  };
}
