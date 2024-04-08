{
  config,
  lib,
  ...
}: {
  imports = [../../../agenix/homeManagerModules/default];

  options.modules.homeManager.programs.gh.enable =
    lib.mkEnableOption "modules.homeManager.programs.gh";

  config = lib.mkIf config.modules.homeManager.programs.gh.enable {
    modules.agenix.homeManagerModules.default.enable = true;

    age.secrets.modulesHomeManagerProgramsGhGhToken.file = ./gh_token.age;

    home.sessionVariables.GH_TOKEN = let
      file = config.age.secrets.modulesHomeManagerProgramsGhGhToken.path;
    in "$(cat ${file})";

    # Prevent configuration drift by avoiding the creation of the runtime
    # authentication darling.
    xdg.configFile."gh/hosts.yml".text = "";

    programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
  };
}
