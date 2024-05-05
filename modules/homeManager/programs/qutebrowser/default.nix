{
  config,
  lib,
  pkgs,
  ...
}: let
  module = "modules.homeManager.programs.qutebrowser";
in {
  imports = [
    ../../home/packages/wl-clipboard
    ../../home/sessionVariables
    ../../xdg
    ../firefox
    ../mpv
    ../xplr
  ];

  options.modules.homeManager.programs.qutebrowser.enable =
    lib.mkEnableOption module;

  config =
    lib.mkIf
    config.modules.homeManager.programs.qutebrowser.enable
    (lib.mkMerge [
      {
        modules.homeManager = {
          home = {
            packages.wl-clipboard.enable = true;

            sessionVariables = {
              BROWSER.enable = true;
              EDITOR.enable = true;
              TERMINAL.enable = true;
              enable = true;
            };
          };

          programs = {
            firefox.enable = true;
            mpv.enable = true;
            xplr.enable = true;
          };
        };

        home.activation.${module} =
          lib.dotfiles.lib.hm.dag.entryBefore.writeBoundary.systemRequirement
          module
          "programs.dconf.enable = true;"
          "https://nix-community.github.io/home-manager/options.xhtml#opt-services.easyeffects.enable";

        programs.qutebrowser = {
          aliases.x = "quit --save";
          enable = true;

          keyBindings.normal = let
            hint = "hint links";
            hintUrl = "'{hint-url}'";

            mpv = {
              audio = "--player-operation-mode=pseudo-gui --vid=no";
              finalPackage = lib.getExe config.programs.mpv.finalPackage;
              loop = "--loop-playlist";
              shuffle = "--shuffle";
            };

            spawn = "spawn --detach --verbose";
            url = "'{url}'";
          in
            lib.concatMapAttrs
            (
              name: value: {"<Space>${name}" = lib.concatStringsSep " " value;}
            )
            {
              "f" = [
                spawn
                (lib.getExe config.programs.firefox.finalPackage)
                url
              ];

              "mA" = [spawn mpv.finalPackage mpv.audio url];
              "mV" = [spawn mpv.finalPackage url];
              "ma" = [hint spawn mpv.finalPackage mpv.audio hintUrl];

              "mlA" = [
                spawn
                mpv.finalPackage
                mpv.loop
                mpv.audio
                mpv.shuffle
                url
              ];

              "mlV" = [spawn mpv.finalPackage mpv.loop url];

              "mla" = [
                hint
                spawn
                mpv.finalPackage
                mpv.loop
                mpv.audio
                mpv.shuffle
                hintUrl
              ];

              "mlv" = [hint spawn mpv.finalPackage mpv.loop hintUrl];
              "mv" = [hint spawn mpv.finalPackage hintUrl];
            };

          settings = let
            xplr = lib.getExe config.programs.xplr.package;
          in {
            colors.webpage = {
              darkmode.enabled = true;
              preferred_color_scheme = "dark";
            };

            content = {
              autoplay = false;
              cookies.store = false;
            };

            editor.command = [
              config.home.sessionVariables.TERMINAL
              "-e"
              pkgs.runtimeShell
              "-c"
              (lib.concatStringsSep " " [
                config.home.sessionVariables.EDITOR
                "-c 'call cursor({line}, {column0})'"
                "--"
                "{file}"
                "&&"
                "nohup"
                (lib.getExe' pkgs.wl-clipboard "wl-copy")
                "< {file}"

                # Redirect all terminal output to '/dev/null' to avoid pesky
                # 'nohup.out' file creations:
                #
                #     If standard error is a terminal, redirect it to standard
                #     output.  To save output to FILE, use 'nohup COMMAND >
                #     FILE'.
                #
                #     -- nohup(1)
                ">/dev/null"
                "2>&1"
              ])
            ];

            fileselect = {
              folder.command = [
                config.home.sessionVariables.TERMINAL
                "-e"
                pkgs.runtimeShell
                "-c"
                "${xplr} --print-pwd-as-result --read-only >{}"
              ];

              handler = "external";

              multiple_files.command = [
                config.home.sessionVariables.TERMINAL
                "-e"
                pkgs.runtimeShell
                "-c"
                "${xplr} --read-only >{}"
              ];

              single_file.command = [
                config.home.sessionVariables.TERMINAL
                "-e"
                pkgs.runtimeShell
                "-c"
                "${xplr} --read-only >{}"
              ];
            };

            input.forward_unbound_keys = "none";
            keyhint.delay = 0;
            messages.timeout = 5000;

            statusbar.widgets = [
              "keypress"
              "search_match"
              "url"
              "scroll"
              "history"
              "progress"
            ];

            tabs.last_close = "default-page";

            zoom.levels = let
              # Considering the small input size and the lack of a built-in
              # power function [2], this naive power implementation should
              # satisfy reasonable performance requirements.
              #
              # Due to the lack of a modulo and bitwise AND operator, it is
              # questionable whether the recursive exponentiation by squaring
              # [1] implementation would even be faster.
              #
              # [1]: https://en.wikipedia.org/wiki/Exponentiation_by_squaring
              # [2]: https://github.com/NixOS/nix/issues/10387
              pow =
                lib.fix
                (
                  self: base: power:
                    if power != 0
                    then base * (self base (power - 1))
                    else 1
                )
                1.5;
            in
              # To avoid excessive memory reallocations, the individual zoom
              # levels are computed from scratch on the CPU, instead of
              # implementing an accumulative multiplication that stores each
              # step in the final list.
              map (level: "${toString (pow level)}%") (lib.range 8 17);
          };
        };
      }

      (
        lib.mkIf (config.modules.homeManager.programs.firefox.enable or false) {
          modules.homeManager.xdg.mimeApps.enable = true;

          xdg.mimeApps.defaultApplications = let
            qutebrowser = "org.qutebrowser.qutebrowser.desktop";
          in {
            "application/xhtml+xml" = [qutebrowser];
            "text/html" = [qutebrowser];
            "text/xml" = [qutebrowser];
            "x-scheme-handler/http" = [qutebrowser];
            "x-scheme-handler/https" = [qutebrowser];
          };
        }
      )
    ]);
}
