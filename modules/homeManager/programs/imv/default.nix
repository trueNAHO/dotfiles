{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.imv.enable = lib.mkEnableOption "imv";

  config = lib.mkIf config.modules.homeManager.programs.imv.enable {
    programs.imv = {
      settings.binds = {
        n = "next";
        p = "prev";
      };

      enable = true;
    };
  };
}
