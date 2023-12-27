{
  config,
  lib,
  ...
}: {
  imports = [../../../agenix/homeManagerModules/default];
  options.modules.homeManager.programs.gh.enable = lib.mkEnableOption "gh";

  config = lib.mkIf config.modules.homeManager.programs.gh.enable {
    modules.agenix.homeManagerModules.default.enable = true;

    age.secrets.modulesHomemanagerProgramsGhToken.file = ./gh_token.age;

    home.sessionVariables.GH_TOKEN = let
      file = config.age.secrets.modulesHomemanagerProgramsGhToken.path;
    in "$(cat ${file})";

    programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
  };
}
