{
  config,
  lib,
  ...
}: {
  imports = [../../../../home/sessionVariables];

  options.modules.homeManager.systemd.user.tmpfiles.rules.enable =
    lib.mkEnableOption "systemd.user.tmpfiles.rules";

  config =
    lib.mkIf
    config.modules.homeManager.systemd.user.tmpfiles.rules.enable {
      modules.homeManager.home.sessionVariables.TMPDIR.enable = true;

      systemd.user.tmpfiles.rules = [
        "d ${config.home.sessionVariables.TMPDIR} - - - bmA:1w"
      ];
    };
}
