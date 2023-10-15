{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.gh.enable = lib.mkEnableOption "gh";

  config = lib.mkIf config.modules.homeManager.programs.gh.enable {
    programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
  };
}
