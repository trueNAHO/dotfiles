{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.imv.enable = lib.mkEnableOption "imv";

  config = lib.mkIf config.modules.homeManager.programs.imv.enable {
    programs.imv.enable = true;
  };
}
