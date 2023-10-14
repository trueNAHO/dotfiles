{
  config,
  lib,
  ...
}: {
  options.modules.programs.ripgrep.enable = lib.mkEnableOption "ripgrep";

  config = lib.mkIf config.modules.programs.ripgrep.enable {
    programs.ripgrep.enable = true;
  };
}
