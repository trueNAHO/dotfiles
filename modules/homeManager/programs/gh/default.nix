{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../../agenix/homeManagerModules/default];

  options.dotfiles.homeManager.programs.gh.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.gh";

  config = lib.mkIf config.dotfiles.homeManager.programs.gh.enable {
    dotfiles.agenix.homeManagerModules.default.enable = true;

    age.secrets.modulesHomeManagerProgramsGhGhToken.file = ./gh_token.age;

    home.sessionVariables.GH_TOKEN = let
      file = config.age.secrets.modulesHomeManagerProgramsGhGhToken.path;
    in ''$(${lib.getExe' pkgs.coreutils "cat"} "${file}")'';

    # Prevent configuration drift by avoiding the creation of the runtime
    # authentication darling.
    xdg.configFile."gh/hosts.yml".text = "";

    programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
  };
}
