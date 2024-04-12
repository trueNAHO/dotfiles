{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../home/packages/asciidoctor
    ../../home/packages/wl-clipboard
    ../../home/sessionVariables
    ../../programs/man
    ../../wayland/windowManager/hyprland
  ];

  options.modules.homeManager.programs.fish.enable =
    lib.mkEnableOption "modules.homeManager.programs.fish";

  config = lib.mkIf config.modules.homeManager.programs.fish.enable {
    home = {
      packages = let
        # TODO: add missing dependencies upstream.
        dependencies.pkgs.fishPlugins = {
          done = [pkgs.libnotify];
          forgit = [pkgs.fzf];
          fzf-fish = with pkgs; [bat fd fish fzf];
        };
      in
        lib.lists.flatten (
          lib.attrsets.attrValues dependencies.pkgs.fishPlugins
        );

      sessionVariables = {
        FORGIT_COPY_CMD = "wl-copy";
        FORGIT_FZF_DEFAULT_OPTS = "--bind=ctrl-j:preview-down --bind=ctrl-k:preview-up";
        FORGIT_NO_ALIASES = 1;
      };
    };

    modules.homeManager = {
      home = {
        packages = {
          asciidoctor.enable = true;
          wl-clipboard.enable = true;
        };

        sessionVariables.SHELL.enable = true;
      };

      programs.man.enable = true;
      wayland.windowManager.hyprland.enable = true;
    };

    programs = {
      fish = {
        enable = true;

        functions = let
          asciidoctor-man = function: {
            body = ''
              ${validateNonEmptyArguments function}

              ${pkgs.asciidoctor-with-extensions.meta.mainProgram} \
                --backend manpage \
                --out-file - \
                $argv |
                ${pkgs.man.meta.mainProgram} \
                --local-file -
            '';

            description = "View Asciidoctor files in Manpage format";
          };

          validateNonEmptyArguments = function: ''
            if not count $argv >/dev/null
              printf '%s\n' "No arguments provided" 1>&2
              functions ${function}
              return 1
            end
          '';
        in {
          _repeat_parent_directory = {
            body = ''
              string repeat --count (math (string length -- $argv[1]) - 1) ../
            '';

            description = "Output parent directory multiple times";
          };

          a = asciidoctor-man "a";
          asciidoctor-man = asciidoctor-man "asciidoctor-man";

          cheat = {
            body = ''${lib.getExe pkgs.curl} --silent cheat.sh/"$argv"'';
            description = "The only cheat sheet you need";
          };

          fish_command_not_found = {
            body = ''
              ${validateNonEmptyArguments "fish_command_not_found"}
              nix run nixpkgs#$argv[1] -- $argv[2..]
            '';

            description = "What to do when a command wasn't found";
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

            description = "Define the appearance of the mode indicator";
          };

          fish_greeting = {
            body = ''
              if set -q fish_private_mode
                printf \
                  '%s\n' \
                  "Private mode: fish will not access old or store new history"
              end
            '';

            description = "Display a welcome message in interactive shells";
          };

          fish_prompt = {
            body = ''
              set -l command_line_status $status

              if test -e /etc/hostname &&
                test "$(cat /etc/hostname)" = $hostname
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

            description = "Define the appearance of the command line prompt";
          };

          fish_right_prompt = {
            body = let
              duration = 5000;
            in ''
              if test $CMD_DURATION -gt ${toString duration}
                set_color -o $fish_color_comment
                printf %s (math "floor ($CMD_DURATION / 100 + 0.5) / 10")s
                set_color $fish_color_normal
              end
            '';

            description = ''
              Define the appearance of the right-side command line prompt
            '';
          };

          mkcd = {
            body = ''
              ${validateNonEmptyArguments "mkcd"}
              mkdir --parent -- $argv && cd -- $argv[1]
            '';

            description = ''
              Make directories, and change working directory to the first one
              specified
            '';
          };

          watcher = {
            body = ''
              ${validateNonEmptyArguments "watcher"}

              ${lib.getExe' pkgs.inotify-tools "inotifywait"} \
                --event create,delete,modify,move \
                --monitor \
                --recursive \
                $argv[1] |
                while read; ${pkgs.runtimeShell} -c "$argv[2..]"; end
            '';

            description = ''
              inotifywait wrapper for recursively watching the first CLI
              argument, and executing the remaining ones on events. This wrapper
              is convenient for CI workflows.
            '';
          };
        };

        interactiveShellInit = ''
          begin
            fish_vi_key_bindings

            # Exclude 'paste' mode to prevent triggering commands when pasting.
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
          switch $(
            read \
              --local \
              --nchars 1 \
              --prompt-str "Start ${graphicalEnvironment}? [y/n] " |
              string lower
          )
            case "" y " "
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

      git = lib.mkIf config.modules.homeManager.programs.git.enable {
        aliases = {
          a = "forgit add";
          b = "forgit checkout_branch";
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
