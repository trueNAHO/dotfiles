{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.man.enable = lib.mkEnableOption "man";

  config = lib.mkIf config.modules.homeManager.programs.man.enable {
    programs.man.enable = true;
  };
}
