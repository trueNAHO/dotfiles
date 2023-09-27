{
  config,
  pkgs,
  ...
}: let
  editor = config.home.sessionVariables.EDITOR;
  leaderKey = "<Space>";
  mpvAudio = "--player-operation-mode=pseudo-gui --vid=no";
  qutebrowserSpawn = "spawn --detach --verbose";
  terminal = config.home.sessionVariables.TERMINAL;
  xplr = "${pkgs.xplr.outPath}/bin/${pkgs.xplr.pname}";
in {
  programs = {
    mpv.enable = true;

    qutebrowser = {
      enable = true;

      keyBindings = {
        normal = {
          "${leaderKey}mA" = "${qutebrowserSpawn} ${pkgs.mpv.meta.mainProgram} ${mpvAudio} '{url}'";
          "${leaderKey}mV" = "${qutebrowserSpawn} ${pkgs.mpv.meta.mainProgram} '{url}'";
          "${leaderKey}ma" = "hint links ${qutebrowserSpawn} ${pkgs.mpv.meta.mainProgram} ${mpvAudio} '{hint-url}'";
          "${leaderKey}mlA" = "${qutebrowserSpawn} ${pkgs.mpv.meta.mainProgram} --loop-playlist ${mpvAudio} '{url}'";
          "${leaderKey}mlV" = "${qutebrowserSpawn} ${pkgs.mpv.meta.mainProgram} --loop-playlist '{url}'";
          "${leaderKey}mla" = "hint links ${qutebrowserSpawn} ${pkgs.mpv.meta.mainProgram} --loop-playlist ${mpvAudio} '{hint-url}'";
          "${leaderKey}mlv" = "hint links ${qutebrowserSpawn} ${pkgs.mpv.meta.mainProgram} --loop-playlist '{hint-url}'";
          "${leaderKey}mv" = "hint links ${qutebrowserSpawn} ${pkgs.mpv.meta.mainProgram} '{hint-url}'";
        };
      };

      settings = {
        content = {
          autoplay = false;
          cookies.store = false;
        };

        editor.command = [
          terminal
          "-e"
          editor
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
