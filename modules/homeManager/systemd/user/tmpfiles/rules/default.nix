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
      systemd.user.tmpfiles.rules = [
        "d ${config.home.homeDirectory}/tmp - - - 1w"
      ];
    };
}
