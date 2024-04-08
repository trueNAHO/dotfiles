{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.zoxide.enable =
    lib.mkEnableOption "modules.homeManager.programs.zoxide";

  config = lib.mkIf config.modules.homeManager.programs.zoxide.enable {
    programs.zoxide.enable = true;
  };
}
