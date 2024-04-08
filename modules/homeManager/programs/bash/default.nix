{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.bash.enable =
    lib.mkEnableOption "modules.homeManager.programs.bash";

  config = lib.mkIf config.modules.homeManager.programs.bash.enable {
    programs.bash.enable = true;
  };
}
