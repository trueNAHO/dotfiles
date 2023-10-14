{
  config,
  lib,
  ...
}: {
  options.modules.programs.bash.enable = lib.mkEnableOption "bash";

  config = lib.mkIf config.modules.programs.bash.enable {
    programs.bash.enable = true;
  };
}
