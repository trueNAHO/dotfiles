{
  config,
  lib,
  ...
}: {
  imports = [../../services/udiskie];

  options.modules.homeManager.programs.bashmount.enable =
    lib.mkEnableOption "bashmount";

  config = lib.mkIf config.modules.homeManager.programs.bashmount.enable {
    modules.homeManager.services.udiskie.enable = true;
    programs.bashmount.enable = true;
  };
}
