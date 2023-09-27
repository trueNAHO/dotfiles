{pkgs, ...}: {
  home.sessionVariables.TERMINAL = pkgs.wezterm.pname;

  programs.wezterm = {
    enable = true;

    extraConfig = ''
      return {
        adjust_window_size_when_changing_font_size = false,
        audible_bell = 'Disabled',
        check_for_updates = false,
        detect_password_input = false,
        disable_default_key_bindings = true,
        enable_tab_bar = false,
        font = wezterm.font 'Monospace',

        keys = {
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
}
