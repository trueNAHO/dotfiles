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
              loop = "--loop-playlist";
              mainProgram = lib.getExe config.programs.mpv.finalPackage;
              shuffle = "--shuffle";
            };

            spawn = "spawn --detach --verbose";
            url = "'{url}'";
          in
            lib.mapAttrs'
            (
              name: value:
                lib.nameValuePair
                "<Space>${name}"
                (lib.concatStringsSep " " value)
            )
            {
              "f" = [
                spawn
                (lib.getExe config.programs.firefox.finalPackage)
                url
              ];

              "mA" = [spawn mpv.mainProgram mpv.audio url];
              "mV" = [spawn mpv.mainProgram url];
              "ma" = [hint spawn mpv.mainProgram mpv.audio hintUrl];

              "mlA" = [
                spawn
                mpv.mainProgram
                mpv.loop
                mpv.audio
                mpv.shuffle
                url
              ];

              "mlV" = [spawn mpv.mainProgram mpv.loop url];

              "mla" = [
                hint
                spawn
                mpv.mainProgram
                mpv.loop
                mpv.audio
                mpv.shuffle
                hintUrl
              ];

              "mlv" = [hint spawn mpv.mainProgram mpv.loop hintUrl];
              "mv" = [hint spawn mpv.mainProgram hintUrl];
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
              "${config.home.sessionVariables.EDITOR} -c 'call cursor({line}, {column0})' -- {file} && nohup ${lib.getExe' pkgs.wl-clipboard "wl-copy"} < {file} >/dev/null 2>&1"
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

            zoom.levels = [
              "25%"
              "33%"
              "50%"
              "67%"
              "75%"
              "90%"
              "100%"
              "110%"
              "125%"
              "150%"
              "175%"
              "200%"
              "250%"
              "300%"
              "400%"
              "500%"
              "600%"
              "700%"
              "800%"
              "900%"
              "1000%"
            ];
          };
        };
      }

      (
        lib.mkIf (
          config
          ? modules.homeManager.programs.firefox.enable
          && config.modules.homeManager.programs.firefox.enable
        ) {
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
