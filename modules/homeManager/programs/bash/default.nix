{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.bash.enable = lib.mkEnableOption "bash";

  config = lib.mkIf config.modules.homeManager.programs.bash.enable {
    programs.bash.enable = true;
  };
}
