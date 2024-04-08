{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.btop.enable =
    lib.mkEnableOption "modules.homeManager.programs.btop";

  config = lib.mkIf config.modules.homeManager.programs.btop.enable {
    programs.btop.enable = true;
  };
}
