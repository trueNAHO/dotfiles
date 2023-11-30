{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../home/packages/wl-clipboard ../mpv ../xplr];

  options.modules.homeManager.programs.qutebrowser.enable =
    lib.mkEnableOption "qutebrowser";

  config = lib.mkIf config.modules.homeManager.programs.qutebrowser.enable {
    home.sessionVariables.BROWSER = pkgs.qutebrowser.pname;

    modules.homeManager = {
      home.packages.wl-clipboard.enable = true;

      programs = {
        mpv.enable = true;
        xplr.enable = true;
      };
    };

    programs.qutebrowser = {
      aliases.x = "quit --save";
      enable = true;

      keyBindings = {
        normal = let
          leaderKey = "<Space>";
          loopPlaylist = "--loop-playlist";
          mpv = pkgs.mpv.meta.mainProgram;
          mpvAudio = "--player-operation-mode=pseudo-gui --vid=no";
          qutebrowserSpawn = "spawn --detach --verbose";
          shuffle = "--shuffle";
        in {
          "${leaderKey}mA" = "${qutebrowserSpawn} ${mpv} ${mpvAudio} '{url}'";
          "${leaderKey}mV" = "${qutebrowserSpawn} ${mpv} '{url}'";
          "${leaderKey}ma" = "hint links ${qutebrowserSpawn} ${mpv} ${mpvAudio} '{hint-url}'";
          "${leaderKey}mlA" = "${qutebrowserSpawn} ${mpv} ${loopPlaylist} ${mpvAudio} ${shuffle} '{url}'";
          "${leaderKey}mlV" = "${qutebrowserSpawn} ${mpv} ${loopPlaylist} '{url}'";
          "${leaderKey}mla" = "hint links ${qutebrowserSpawn} ${mpv} ${loopPlaylist} ${mpvAudio} ${shuffle} '{hint-url}'";
          "${leaderKey}mlv" = "hint links ${qutebrowserSpawn} ${mpv} ${loopPlaylist} '{hint-url}'";
          "${leaderKey}mv" = "hint links ${qutebrowserSpawn} ${mpv} '{hint-url}'";
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
  };
}
