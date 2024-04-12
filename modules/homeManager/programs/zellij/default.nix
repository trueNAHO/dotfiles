{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../home/sessionVariables];

  options.modules.homeManager.programs.zellij.enable =
    lib.mkEnableOption "modules.homeManager.programs.zellij";

  config =
    lib.mkIf
    config.modules.homeManager.programs.zellij.enable
    (lib.mkMerge [
      {
        modules.homeManager.home.sessionVariables.EDITOR.enable = true;

        programs = {
          zellij = {
            enable = true;

            settings = {
              scroll_buffer_size = 100000;

              scrollback_editor = lib.getExe (pkgs.writeShellApplication {
                name = "scrollback_editor";
                text = ''
                  ${config.home.sessionVariables.EDITOR} \
                    -c 'silent $ | set norelativenumber' \
                    "$@"
                '';
              });

              simplified_ui = true;
            };
          };

          fish.interactiveShellInit =
            lib.mkBefore
            "test -z $ZELLIJ; and exec ${pkgs.zellij.pname}";
        };

        # Partially declare the literal KDL configuration as a string rather
        # than a Nix expression due to lacking upstream support.
        xdg.configFile = {
          "zellij/config.kdl".text = let
            goToTab = builtins.concatStringsSep "\n" (
              map (
                index: let
                  indexString = toString index;
                in ''
                  bind "Alt ${indexString}" {
                    GoToTab ${indexString}; SwitchToMode "normal"
                  }
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
                  bind "Alt C" { Clear; }
                  bind "Alt D" { Detach; }
                  bind "Alt H" { Resize "Decrease"; }
                  bind "Alt J" { MovePane; }
                  bind "Alt K" { MovePaneBackwards; }
                  bind "Alt L" { Resize "Increase"; }
                  bind "Alt Q" { CloseFocus; SwitchToMode "normal"; }
                  bind "Alt W" { ToggleFloatingPanes; SwitchToMode "normal"; }
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

                  bind "Alt w" {
                    TogglePaneEmbedOrFloating; SwitchToMode "normal"
                  }
                }
              }
            '';

          "zellij/layouts/default.kdl".text = ''
            layout {
              swap_tiled_layout name="horizontal" {
                tab max_panes=5 {
                  pane
                  pane
                }

                tab max_panes=8 {
                  pane {
                    pane split_direction="vertical" { children; }
                    pane split_direction="vertical" { pane; pane; pane; pane; }
                  }
                }

                tab max_panes=12 {
                  pane {
                    pane split_direction="vertical" { children; }
                    pane split_direction="vertical" { pane; pane; pane; pane; }
                    pane split_direction="vertical" { pane; pane; pane; pane; }
                  }
                }
              }

              swap_tiled_layout name="vertical" {
                tab max_panes=5 {
                  pane split_direction="vertical" {
                    pane
                    pane { children; }
                  }
                }

                tab max_panes=8 {
                  pane split_direction="vertical" {
                    pane { children; }
                    pane { pane; pane; pane; pane; }
                  }
                }

                tab max_panes=12 {
                  pane split_direction="vertical" {
                    pane { children; }
                    pane { pane; pane; pane; pane; }
                    pane { pane; pane; pane; pane; }
                  }
                }
              }

              swap_tiled_layout name="stacked" {
                tab min_panes=5 {
                  pane split_direction="vertical" {
                    pane
                    pane stacked=true { children; }
                  }
                }
              }

              swap_floating_layout name="staggered" {
                floating_panes
              }

              swap_floating_layout name="enlarged" {
                floating_panes max_panes=10 {
                  pane { x "5%"; y 1; width "90%"; height "90%"; }
                  pane { x "5%"; y 2; width "90%"; height "90%"; }
                  pane { x "5%"; y 3; width "90%"; height "90%"; }
                  pane { x "5%"; y 4; width "90%"; height "90%"; }
                  pane { x "5%"; y 5; width "90%"; height "90%"; }
                  pane { x "5%"; y 6; width "90%"; height "90%"; }
                  pane { x "5%"; y 7; width "90%"; height "90%"; }
                  pane { x "5%"; y 8; width "90%"; height "90%"; }
                  pane { x "5%"; y 9; width "90%"; height "90%"; }
                  pane focus=true { x 10; y 10; width "90%"; height "90%"; }
                }
              }

              swap_floating_layout name="spread" {
                floating_panes max_panes=1 {
                  pane {y "50%"; x "50%"; }
                }

                floating_panes max_panes=2 {
                  pane { x "1%"; y "25%"; width "45%"; }
                  pane { x "50%"; y "25%"; width "45%"; }
                }

                floating_panes max_panes=3 {
                  pane focus=true { y "55%"; width "45%"; height "45%"; }
                  pane { x "1%"; y "1%"; width "45%"; }
                  pane { x "50%"; y "1%"; width "45%"; }
                }

                floating_panes max_panes=4 {
                  pane { x "1%"; y "55%"; width "45%"; height "45%"; }

                  pane focus=true {
                    x "50%"; y "55%"; width "45%"; height "45%"
                  }

                  pane { x "1%"; y "1%"; width "45%"; height "45%"; }
                  pane { x "50%"; y "1%"; width "45%"; height "45%"; }
                }
              }
            }
          '';
        };
      }

      (
        lib.mkIf (
          config
          ? wayland.windowManager.hyprland.enable
          && config.wayland.windowManager.hyprland.enable
        ) {
          home.shellAliases.${pkgs.hyprland.meta.mainProgram} = ''ZELLIJ="" ${lib.getExe pkgs.hyprland}'';
        }
      )
    ]);
}
