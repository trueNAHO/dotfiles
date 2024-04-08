{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.jq.enable =
    lib.mkEnableOption "modules.homeManager.programs.jq";

  config = lib.mkIf config.modules.homeManager.programs.jq.enable {
    programs.jq.enable = true;
  };
}
