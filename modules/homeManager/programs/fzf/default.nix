{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.fzf.enable =
    lib.mkEnableOption "modules.homeManager.programs.fzf";

  config = lib.mkIf config.modules.homeManager.programs.fzf.enable {
    programs.fzf.enable = true;
  };
}
