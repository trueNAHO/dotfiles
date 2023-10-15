{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.home-manager.enable =
    lib.mkEnableOption "Home Manager";

  config = lib.mkIf config.modules.homeManager.programs.home-manager.enable {
    programs.home-manager.enable = true;
  };
}
