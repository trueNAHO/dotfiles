{
  config,
  lib,
  ...
}: {
  options.modules.programs.home-manager.enable =
    lib.mkEnableOption "Home Manager";

  config = lib.mkIf config.modules.programs.home-manager.enable {
    programs.home-manager.enable = true;
  };
}
