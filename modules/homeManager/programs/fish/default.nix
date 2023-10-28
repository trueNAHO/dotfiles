{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../home/packages/fd
    ../../home/packages/wl-clipboard
    ../../wayland/windowManager/hyprland
  ];
  options.modules.homeManager.programs.fish.enable = lib.mkEnableOption "fish";

  config = lib.mkIf config.modules.homeManager.programs.fish.enable {
    home = let
      pluginDependencies.fishPlugins = {
        done = [pkgs.libnotify];
        forgit = [pkgs.fzf];
        fzf-fish = with pkgs; [bat fd fish fzf];
      };
    in {
      packages = with pluginDependencies.fishPlugins;
        done ++ forgit ++ fzf-fish;

      sessionVariables = {
        FORGIT_COPY_CMD = "wl-copy";
        FORGIT_FZF_DEFAULT_OPTS = "--bind=ctrl-j:preview-down --bind=ctrl-k:preview-up";
        FORGIT_NO_ALIASES = 1;
        SHELL = pkgs.fish.pname;
      };
    };

    modules.homeManager = {
      home.packages = {
        fd.enable = true;
        wl-clipboard.enable = true;
      };

      wayland.windowManager.hyprland.enable = true;
    };

    programs = {
      fish = {
        enable = true;

        functions = {
          _repeat_parent_directory = {
            body = "string repeat --count (math (string length -- $argv[1]) - 1) ../";
            description = "Output parent directory multiple times";
          };

          fish_command_not_found = {
            body = "nix run nixpkgs#$argv[1] -- $argv[2..]";
            description = "Run a Nix application";
          };

          fish_mode_prompt = {
            body = ''
              if test "$fish_key_bindings" = fish_vi_key_bindings
                or test "$fish_key_bindings" = fish_hybrid_key_bindings
                switch $fish_bind_mode
                  case insert
                    set_color -o $fish_color_normal
                    printf %s '[I] '
                  case default
                    set_color -o $fish_color_param
                    printf %s '[N] '
                  case visual
                    set_color -o $fish_color_operator
                    printf %s '[V] '
                  case replace replace_one
                    set_color -o $fish_color_error
                    printf %s '[R] '
                end

                set_color $fish_color_normal
              end
            '';

            description = "Output mode";
          };

          fish_greeting = {
            body = ''
              if set -q fish_private_mode
                printf \
                  '%s\n' \
                  "Private mode: fish will not access old or store new history"
              end
            '';

            description = "Output greeting";
          };

          fish_prompt = {
            body = ''
              set -l command_line_status $status

              if test -e /etc/hostname && test "$(cat /etc/hostname)" = $hostname;
                set -f user_hostname ""
              else
                set -f user_hostname $USER@$hostname
              end

              if fish_is_root_user
                set -f prompt_character '#'
              else
                set -f prompt_character '$'
              end

              if test $command_line_status -eq 0
                set_color -o $fish_color_normal
              else
                set_color -o $fish_color_error
              end

              printf %s $user_hostname$prompt_character' '
              set_color $fish_color_normal
            '';

            description = "Output left prompt";
          };

          fish_right_prompt = {
            body = ''
              if test $CMD_DURATION -gt 5000
                set_color -o $fish_color_comment
                printf %s (math "floor ($CMD_DURATION / 100 + 0.5) / 10")s
                set_color $fish_color_normal
              end
            '';

            description = "Output right prompt";
          };

          mkcd = {
            body = "mkdir --parent -- $argv && cd -- $argv[1]";
            description = "Make directories, and change working directory to the first one specified";
          };
        };

        interactiveShellInit = ''
          begin
            fish_vi_key_bindings

            # Exclude 'paste' mode to prevent tiggering commands when pasting.
            for mode in (bind --list-modes | string match --invert paste)
              bind --mode $mode --user \ce edit_command_buffer
              bind --mode $mode --user \cp __fish_paginate
            end

            set fish_cursor_insert line
            set fish_cursor_replace_one underscore
          end

          fzf_configure_bindings

          fish_add_path \
            ${pkgs.fishPlugins.forgit.outPath}/share/fish/vendor_conf.d/bin

          abbr \
            --add multi_dot \
            --position anywhere \
            --regex '\.\.+' \
            --function _repeat_parent_directory
        '';

        loginShellInit = let
          graphicalEnvironment = pkgs.hyprland.meta.mainProgram;
        in ''
          read -l -P "Start ${graphicalEnvironment}? [y/n] " reply

          switch $(string lower $reply)
            case "" y yes
              exec ${graphicalEnvironment}
          end
        '';

        plugins = [
          {
            name = pkgs.fishPlugins.done.pname;
            src = pkgs.fishPlugins.done.src;
          }

          {
            name = pkgs.fishPlugins.forgit.pname;
            src = pkgs.fishPlugins.forgit.src;
          }

          {
            name = pkgs.fishPlugins.fzf-fish.pname;
            src = pkgs.fishPlugins.fzf-fish.src;
          }
        ];
      };

      git = {
        aliases = {
          a = "forgit add";
          b = "forgit checkout_branch";
          c = "forgit checkout_commit";
          cp = "forgit cherry_pick";
          d = "forgit diff";
          f = "forgit checkout_file";
          i = "forgit ignore";
          l = "forgit log";
          rb = "forgit rebase";
          sp = "forgit stash_push";
          ss = "forgit stash_show";
          t = "forgit checkout_tag";
        };
      };
    };
  };
}
