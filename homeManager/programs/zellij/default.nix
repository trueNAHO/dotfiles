{
  lib,
  pkgs,
  ...
}: {
  programs = {
    zellij = {
      enable = true;

      settings = {
        default_layout = "compact";
        scroll_buffer_size = 100000;
        simplified_ui = true;
      };
    };

    fish.interactiveShellInit = (
      lib.mkBefore
      "set -q ZELLIJ; or exec ${pkgs.zellij.pname}"
    );
  };

  xdg.configFile."zellij/config.kdl".text = lib.mkAfter ''
    keybinds clear-defaults=true {
      locked {
        bind "Esc" { SwitchToMode "normal"; }
      }

      normal {
        bind "Alt 1" { GoToTab 1; SwitchToMode "normal"; }
        bind "Alt 2" { GoToTab 2; SwitchToMode "normal"; }
        bind "Alt 3" { GoToTab 3; SwitchToMode "normal"; }
        bind "Alt 4" { GoToTab 4; SwitchToMode "normal"; }
        bind "Alt 5" { GoToTab 5; SwitchToMode "normal"; }
        bind "Alt 6" { GoToTab 6; SwitchToMode "normal"; }
        bind "Alt 7" { GoToTab 7; SwitchToMode "normal"; }
        bind "Alt 8" { GoToTab 8; SwitchToMode "normal"; }
        bind "Alt 9" { GoToTab 9; SwitchToMode "normal"; }
        bind "Alt D" { Detach; }
        bind "Alt H" { Resize "Decrease"; }
        bind "Alt J" { MovePaneBackwards; }
        bind "Alt K" { MovePane; }
        bind "Alt L" { Resize "Increase"; }
        bind "Alt Q" { CloseFocus; SwitchToMode "normal"; }
        bind "Alt W" { TogglePaneEmbedOrFloating; SwitchToMode "normal"; }
        bind "Alt X" { SwitchToMode "locked"; }
        bind "Alt c" { NewTab; SwitchToMode "normal"; }
        bind "Alt e" { EditScrollback; SwitchToMode "normal"; }
        bind "Alt f" { ToggleFocusFullscreen; SwitchToMode "normal"; }
        bind "Alt h" { GoToPreviousTab; }
        bind "Alt j" { FocusNextPane; }
        bind "Alt k" { FocusPreviousPane; }
        bind "Alt l" { GoToNextTab; }
        bind "Alt n" { NextSwapLayout; }
        bind "Alt p" { PreviousSwapLayout; }
        bind "Alt t" { NewPane; SwitchToMode "normal"; }
        bind "Alt w" { ToggleFloatingPanes; SwitchToMode "normal"; }
      }
    }
  '';
}
