{
  config,
  lib,
  ...
}: {
  options.modules.programs.gpg.enable = lib.mkEnableOption "gpg";

  config = lib.mkIf config.modules.programs.gpg.enable {
    programs.gpg.enable = true;
  };
}
