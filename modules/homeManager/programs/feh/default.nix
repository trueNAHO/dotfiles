{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.feh.enable =
    lib.mkEnableOption "modules.homeManager.programs.feh";

  config = lib.mkIf config.modules.homeManager.programs.feh.enable {
    programs.feh.enable = true;
  };
}
