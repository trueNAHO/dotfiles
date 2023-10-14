{
  config,
  lib,
  ...
}: {
  options.modules.programs.zoxide.enable = lib.mkEnableOption "zoxide";

  config = lib.mkIf config.modules.programs.zoxide.enable {
    programs.zoxide.enable = true;
  };
}
