{
  config,
  lib,
  ...
}: {
  options.modules.programs.fzf.enable = lib.mkEnableOption "fzf";

  config = lib.mkIf config.modules.programs.fzf.enable {
    programs.fzf.enable = true;
  };
}
