{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.programs.jq.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.jq";

  config = lib.mkIf config.dotfiles.homeManager.programs.jq.enable {
    programs.jq.enable = true;
  };
}
