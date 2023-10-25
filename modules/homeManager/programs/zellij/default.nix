{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../wayland/windowManager/hyprland];

  options.modules.homeManager.programs.zellij.enable =
    lib.mkEnableOption "zellij";

  config = lib.mkIf config.modules.homeManager.programs.zellij.enable {
    modules.homeManager.wayland.windowManager.hyprland.enable = true;

    home.shellAliases.${pkgs.hyprland.meta.mainProgram} = let
      hyprland = pkgs.hyprland;
    in ''ZELLIJ="" ${hyprland}/bin/${hyprland.meta.mainProgram}'';

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
        "test -z $ZELLIJ; and exec ${pkgs.zellij.pname}"
      );
    };

    xdg.configFile."zellij/config.kdl".text = let
      application = pkgs.writeShellApplication {
        name = "scrollback_editor";
        text = ''${config.home.sessionVariables.EDITOR} -c '$ | set norelativenumber' "$@"'';
      };

      goToTab = builtins.concatStringsSep "\n" (
        map (
          index: let
            indexString = toString index;
          in ''
            bind "Alt ${indexString}" { GoToTab ${indexString}; SwitchToMode "normal"; }
          ''
        ) (lib.lists.range 1 9)
      );
    in
      lib.mkAfter ''
        keybinds clear-defaults=true {
          locked {
            bind "Esc" { SwitchToMode "normal"; }
          }

          normal {
            ${goToTab}
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

        scrollback_editor "${application}/bin/${application.meta.mainProgram}";
      '';
  };
}
