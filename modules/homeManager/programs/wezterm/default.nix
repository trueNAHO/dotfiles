{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.wezterm.enable =
    lib.mkEnableOption "wezterm";

  config = lib.mkIf config.modules.homeManager.programs.wezterm.enable {
    home.sessionVariables.TERMINAL = pkgs.wezterm.pname;

    programs.wezterm = {
      enable = true;

      extraConfig = ''
        return {
          adjust_window_size_when_changing_font_size = false,
          audible_bell = 'Disabled',
          check_for_updates = false,
          default_prog = { '${config.home.sessionVariables.SHELL}' },
          detect_password_input = false,
          disable_default_key_bindings = true,
          enable_tab_bar = false,
          font = wezterm.font 'Monospace',

          keys = {
            {
              action = wezterm.action.CopyTo 'Clipboard',
              key = 'c',
              mods = 'CTRL|SHIFT',
            },

            {
              action = wezterm.action.DecreaseFontSize,
              key = '-',
              mods = 'ALT',
            },

            {
              action = wezterm.action.IncreaseFontSize,
              key = '+',
              mods = 'ALT|SHIFT',
            },

            {
              action = wezterm.action.PasteFrom 'Clipboard',
              key = 'v',
              mods = 'CTRL|SHIFT',
            },

            {
              action = wezterm.action.ResetFontSize,
              key = '=',
              mods = 'ALT',
            },
          },

          window_close_confirmation = 'NeverPrompt',

          window_padding = {
            bottom = '0.25cell',
            left = '0.5cell',
            right = '0.5cell',
            top = '0.25cell',
          },
        }
      '';
    };
  };
}
