{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../mpv ../xplr];

  options.modules.homeManager.programs.qutebrowser.enable =
    lib.mkEnableOption "qutebrowser";

  config = lib.mkIf config.modules.homeManager.programs.qutebrowser.enable {
    home.sessionVariables.BROWSER = pkgs.qutebrowser.pname;

    modules.homeManager.programs = {
      mpv.enable = true;
      xplr.enable = true;
    };

    programs.qutebrowser = {
      enable = true;

      keyBindings = {
        normal = let
          leaderKey = "<Space>";
          mpv = pkgs.mpv.meta.mainProgram;
          mpvAudio = "--player-operation-mode=pseudo-gui --vid=no";
          qutebrowserSpawn = "spawn --detach --verbose";
        in {
          "${leaderKey}mA" = "${qutebrowserSpawn} ${mpv} ${mpvAudio} '{url}'";
          "${leaderKey}mV" = "${qutebrowserSpawn} ${mpv} '{url}'";
          "${leaderKey}ma" = "hint links ${qutebrowserSpawn} ${mpv} ${mpvAudio} '{hint-url}'";
          "${leaderKey}mlA" = "${qutebrowserSpawn} ${mpv} --loop-playlist ${mpvAudio} '{url}'";
          "${leaderKey}mlV" = "${qutebrowserSpawn} ${mpv} --loop-playlist '{url}'";
          "${leaderKey}mla" = "hint links ${qutebrowserSpawn} ${mpv} --loop-playlist ${mpvAudio} '{hint-url}'";
          "${leaderKey}mlv" = "hint links ${qutebrowserSpawn} ${mpv} --loop-playlist '{hint-url}'";
          "${leaderKey}mv" = "hint links ${qutebrowserSpawn} ${mpv} '{hint-url}'";
        };
      };

      settings = let
        terminal = config.home.sessionVariables.TERMINAL;
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
          terminal
          "-e"
          config.home.sessionVariables.EDITOR
          "-c"
          "call setpos('.', [0, {line}, {column0}, 0])"
          "--"
          "{file}"
        ];

        fileselect = {
          folder.command = [
            terminal
            "-e"
            xplr
            "--print-pwd-as-result"
            "--read-only"
          ];

          handler = "external";
          multiple_files.command = [terminal "-e" xplr];
          single_file.command = [terminal "-e" xplr];
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