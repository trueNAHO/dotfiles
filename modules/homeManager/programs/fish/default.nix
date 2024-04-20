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

  # TODO: Add missing fish plugin dependencies upstream.
  config =
    lib.mkIf
    config.modules.homeManager.programs.fish.enable
    (lib.mkMerge [
      {
        modules.homeManager = {
          home = {
            packages.asciidoctor.enable = true;
            sessionVariables.SHELL.enable = true;
          };

          programs.man.enable = true;
          wayland.windowManager.hyprland.enable = true;
        };

        programs.fish = {
          enable = true;

          functions = let
            asciidoctor-man = function: {
              body = validateFunctionArguments function ''
                ${pkgs.asciidoctor-with-extensions.meta.mainProgram} \
                  --backend manpage \
                  --out-file - \
                  $argv |
                  ${pkgs.man.meta.mainProgram} \
                  --local-file -
              '';

              description = "View Asciidoctor files in Manpage format";
            };

            fishModePrompt = prefix: {
              body = ''
                switch $fish_key_bindings
                  case fish_hybrid_key_bindings fish_vi_key_bindings
                    switch $fish_bind_mode
                      case insert
                        set --function color $fish_color_normal
                        set --function mode I

                      case default
                        set --function color $fish_color_param
                        set --function mode N

                      case visual
                        set --function color $fish_color_operator
                        set --function mode V

                      case replace replace_one
                        set --function color $fish_color_error
                        set --function mode R
                    end

                    ${prefix}

                    set_color --bold $color
                    printf '[%s] ' $mode
                    set_color $fish_color_normal
                end
              '';

              description = "Define the appearance of the mode indicator";
            };

            validateFunctionArguments = function: body: ''
              if not count $argv >/dev/null
                set_color --bold $fish_color_error
                printf '%s\n' "No arguments provided" 1>&2
                set_color $fish_color_normal

                functions ${function}

                return 123
              end

              ${body}
            '';
          in {
            _repeat_parent_directory = {
              body = ''
                string \
                  repeat \
                  --count (math (string length -- $argv[1]) - 1) \
                  ../
              '';

              description = "Output parent directory multiple times";
            };

            a = asciidoctor-man "a";
            asciidoctor-man = asciidoctor-man "asciidoctor-man";

            cheat = {
              body = ''${lib.getExe pkgs.curl} --silent "cheat.sh/$argv"'';
              description = "The only cheat sheet you need";
            };

            fish_command_not_found = {
              body =
                validateFunctionArguments
                "fish_command_not_found"
                "nix run nixpkgs#$argv[1] -- $argv[2..]";

              description = "What to do when a command wasn't found";
            };

            fish_mode_prompt = fishModePrompt "";

            fish_greeting = {
              body = let
                fishModePromptPrivate = let
                  prefix = ''
                    set_color --bold $fish_color_comment
                    printf '[%s] ' P
                    set_color $fish_color_normal
                  '';
                in ''
                  function fish_mode_prompt
                    ${(fishModePrompt prefix).body}
                  end
                '';
              in ''
                if not set -q fish_private_mode
                  return
                end

                ${fishModePromptPrivate}

                set_color --italics $fish_color_error

                printf \
                  'Private mode: %s\n' \
                  "fish will not access old or store new history"

                set_color $fish_color_normal
              '';

              description = "Display a welcome message in interactive shells";
            };

            fish_prompt = {
              body = ''
                if test $status -eq 0
                  set --function color $fish_color_normal
                else
                  set --function color $fish_color_error
                end

                if set -q SSH_CLIENT ||
                    set -q SSH_CONNECTION ||
                    set -q SSH_TTY
                  set --function user_hostname "$USER@$hostname "
                end

                if fish_is_root_user
                  set --function prompt_character "#"
                else
                  set --function prompt_character '$'
                end

                set_color --bold $color
                printf '%s%s ' $user_hostname $prompt_character
                set_color $fish_color_normal
              '';

              description = ''
                Define the appearance of the command line prompt
              '';
            };

            fish_right_prompt = {
              body = let
                duration = 5000;
              in ''
                set --function command_status $status

                if test $command_status -ne 0
                  set --function command_status_suffix " "

                  set_color --bold $fish_color_error
                  printf '(%s)' $command_status
                  set_color $fish_color_normal
                end

                if test $CMD_DURATION -ge ${toString duration}
                  set_color --bold $fish_color_comment

                  printf \
                    '%s%ss' \
                    $command_status_suffix \
                    (math "floor ($CMD_DURATION / 100 + 0.5) / 10")

                  set_color $fish_color_normal
                end
              '';

              description = ''
                Define the appearance of the right-side command line prompt
              '';
            };

            mkcd = {
              body =
                validateFunctionArguments
                "mkcd"
                "mkdir --parent -- $argv && cd -- $argv[1]";

              description = ''
                Make directories, and change working directory to the first
                one specified
              '';
            };

            watcher = {
              body = validateFunctionArguments "watcher" ''
                ${lib.getExe' pkgs.inotify-tools "inotifywait"} \
                  --event create,delete,modify,move \
                  --monitor \
                  --recursive \
                  $argv[1] |
                  while read; ${pkgs.runtimeShell} -c "$argv[2..]"; end
              '';

              description = ''
                inotifywait wrapper for recursively watching the first CLI
                argument, and executing the remaining ones on events. This
                wrapper is convenient for CI workflows.
              '';
            };
          };

          interactiveShellInit = ''
            # https://fishshell.com/docs/current/interactive.html#vi-mode-commands
            begin
              fish_vi_key_bindings

              # Exclude 'paste' mode to prevent triggering commands when
              # pasting.
              for mode in (bind --list-modes | string match --invert paste)
                bind --mode $mode --user \ce edit_command_buffer
                bind --mode $mode --user \cp __fish_paginate
              end

              set --global fish_cursor_insert line
              set --global fish_cursor_replace underscore
              set --global fish_cursor_replace_one underscore
            end

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
        };
      }

      {
        home.packages = [pkgs.libnotify];

        programs.fish = {
          plugins = let
            done = pkgs.fishPlugins.done;
          in [
            {
              inherit (done) src;
              name = done.pname;
            }
          ];
        };
      }

      {
        modules.homeManager.home.packages.wl-clipboard.enable = true;

        home = {
          packages = [pkgs.fzf];

          sessionVariables = {
            FORGIT_COPY_CMD = "wl-copy";

            FORGIT_FZF_DEFAULT_OPTS =
              lib.concatMapStringsSep
              " "
              (
                {
                  name,
                  value,
                }: "--bind=${name}:${value}"
              )
              [
                (lib.nameValuePair "ctrl-j" "preview-down")
                (lib.nameValuePair "ctrl-k" "preview-up")
              ];

            FORGIT_NO_ALIASES = 1;
          };
        };

        programs = {
          fish = let
            forgit = pkgs.fishPlugins.forgit;
          in {
            plugins = [
              {
                inherit (forgit) src;
                name = forgit.pname;
              }
            ];

            interactiveShellInit = ''
              fish_add_path ${forgit.outPath}/share/fish/vendor_conf.d/bin
            '';
          };

          git.aliases = let
            forgit = "forgit";
          in
            lib.mkIf config.modules.homeManager.programs.git.enable {
              a = "${forgit} add";
              b = "${forgit} checkout_branch";
              cp = "${forgit} cherry_pick";
              d = "${forgit} diff";
              f = "${forgit} checkout_file";
              i = "${forgit} ignore";
              l = "${forgit} log";
              rb = "${forgit} rebase";
              sp = "${forgit} stash_push";
              ss = "${forgit} stash_show";
              t = "${forgit} checkout_tag";
            };
        };
      }

      {
        home.packages = with pkgs; [bat fd fish fzf];

        programs.fish = {
          interactiveShellInit = "fzf_configure_bindings";

          plugins = let
            fzf-fish = pkgs.fishPlugins.fzf-fish;
          in [
            {
              inherit (fzf-fish) src;
              name = fzf-fish.pname;
            }
          ];
        };
      }
    ]);
}
