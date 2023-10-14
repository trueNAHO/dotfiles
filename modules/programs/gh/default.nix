{
  config,
  lib,
  ...
}: {
  options.modules.programs.gh.enable = lib.mkEnableOption "gh";

  config = lib.mkIf config.modules.programs.gh.enable {
    programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
  };
}
