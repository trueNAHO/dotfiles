{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.btop.enable = lib.mkEnableOption "btop";

  config = lib.mkIf config.modules.homeManager.programs.btop.enable {
    programs.btop.enable = true;
  };
}
