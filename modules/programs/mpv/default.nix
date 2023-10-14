{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.mpv.enable = lib.mkEnableOption "mpv";

  config = lib.mkIf config.modules.programs.mpv.enable {
    programs.mpv = {
      enable = true;

      scriptOpts = {
        playlistmanager.key_showplaylist = "F8";
        thumbfast.network = "yes";
        uosc.top_bar_controls = "no";
      };

      scripts = with pkgs.mpvScripts; [mpv-playlistmanager thumbfast uosc];
    };
  };
}
