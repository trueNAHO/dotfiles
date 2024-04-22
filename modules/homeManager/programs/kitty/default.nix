{
  config,
  lib,
  ...
}: {
  imports = [../../home/sessionVariables];

  options.modules.homeManager.programs.kitty.enable =
    lib.mkEnableOption "modules.homeManager.programs.kitty";

  config = lib.mkIf config.modules.homeManager.programs.kitty.enable {
    modules.homeManager.home.sessionVariables = {
      TERMINAL.enable = true;
      enable = true;
    };

    programs.kitty = {
      enable = true;

      keybindings = let
        change_font_size_value = toString 0.5;
      in
        lib.mkMerge (
          map ({
            name,
            value,
          }: {${lib.concatStringsSep "+" name} = value;}) [
            (lib.nameValuePair ["alt" "equal"] "change_font_size all 0")

            (
              lib.nameValuePair
              ["alt" "minus"]
              "change_font_size all -${change_font_size_value}"
            )

            (
              lib.nameValuePair
              ["alt" "plus"]
              "change_font_size all +${change_font_size_value}"
            )

            (lib.nameValuePair ["kitty_mod" "c"] "copy_to_clipboard")
            (lib.nameValuePair ["kitty_mod" "v"] "paste_from_clipboard")
          ]
        );

      settings = {
        clear_all_shortcuts = true;
        confirm_os_window_close = 0;
        enable_audio_bell = false;
        input_delay = 0;
        window_margin_width = 2;
      };
    };
  };
}
