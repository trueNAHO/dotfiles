{
  config,
  lib,
  ...
}: {
  imports = [../../../../home/sessionVariables];

  options.dotfiles.homeManager.systemd.user.tmpfiles.rules.enable =
    lib.mkEnableOption "dotfiles.homeManager.systemd.user.tmpfiles.rules";

  config =
    lib.mkIf
    config.dotfiles.homeManager.systemd.user.tmpfiles.rules.enable {
      dotfiles.homeManager.home.sessionVariables = {
        TMPDIR.enable = true;
        enable = true;
      };

      systemd.user.tmpfiles.rules = [
        "d ${config.home.sessionVariables.TMPDIR} - - - bmA:1w"
      ];
    };
}
