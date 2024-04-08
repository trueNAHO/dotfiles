{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.home-manager.enable =
    lib.mkEnableOption "home-manager";

  config = lib.mkIf config.modules.homeManager.programs.home-manager.enable {
    programs.home-manager.enable = true;
  };
}
