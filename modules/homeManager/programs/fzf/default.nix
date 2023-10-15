{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.fzf.enable = lib.mkEnableOption "fzf";

  config = lib.mkIf config.modules.homeManager.programs.fzf.enable {
    programs.fzf.enable = true;
  };
}
