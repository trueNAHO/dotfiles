{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.systemd.user.tmpfiles.rules.enable =
    lib.mkEnableOption "systemd.user.tmpfiles.rules";

  config =
    lib.mkIf
    config.modules.homeManager.systemd.user.tmpfiles.rules.enable {
      home.sessionVariables.TMPDIR = "${config.home.homeDirectory}/tmp";

      systemd.user.tmpfiles.rules = [
        "d ${config.home.sessionVariables.TMPDIR} - - - bmA:1w"
      ];
    };
}
