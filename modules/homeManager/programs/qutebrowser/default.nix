{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../home/packages/wl_clipboard
    ../../xdg
    ../firefox
    ../mpv
    ../xplr
  ];

  options.modules.homeManager.programs.qutebrowser.enable =
    lib.mkEnableOption "qutebrowser";

  config =
    lib.mkIf
    config.modules.homeManager.programs.qutebrowser.enable
    (lib.mkMerge [
      {
        home.sessionVariables.BROWSER = pkgs.qutebrowser.pname;

        modules.homeManager = {
          home.packages.wl-clipboard.enable = true;

          programs = {
            firefox.enable = true;
            mpv.enable = true;
            xplr.enable = true;
          };
        };

        programs.qutebrowser = {
          aliases.x = "quit --save";
          enable = true;

          keyBindings = {
            normal = let
              leader = "<Space>";
              mpv = pkgs.mpv.meta.mainProgram;
              mpvAudio = "--player-operation-mode=pseudo-gui --vid=no";
              mpvLoopPlaylist = "--loop-playlist";
              mpvShuffle = "--shuffle";
              spawn = "spawn --detach --verbose";
            in {
              "${leader}f" = "${spawn} firefox '{url}'";
              "${leader}mA" = "${spawn} ${mpv} ${mpvAudio} '{url}'";
              "${leader}mV" = "${spawn} ${mpv} '{url}'";
              "${leader}ma" = "hint links ${spawn} ${mpv} ${mpvAudio} '{hint-url}'";
              "${leader}mlA" = "${spawn} ${mpv} ${mpvLoopPlaylist} ${mpvAudio} ${mpvShuffle} '{url}'";
              "${leader}mlV" = "${spawn} ${mpv} ${mpvLoopPlaylist} '{url}'";
              "${leader}mla" = "hint links ${spawn} ${mpv} ${mpvLoopPlaylist} ${mpvAudio} ${mpvShuffle} '{hint-url}'";
              "${leader}mlv" = "hint links ${spawn} ${mpv} ${mpvLoopPlaylist} '{hint-url}'";
              "${leader}mv" = "hint links ${spawn} ${mpv} '{hint-url}'";
            };
          };

          settings = let
            xplr = pkgs.xplr.pname;
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
              "${config.home.sessionVariables.EDITOR} -c 'call cursor({line}, {column0})' -- {file} && nohup wl-copy < {file} >/dev/null 2>&1"
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

      (lib.mkIf config.modules.homeManager.programs.firefox.enable {
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
      })
    ]);
}
