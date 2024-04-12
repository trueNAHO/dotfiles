{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.eza.enable =
    lib.mkEnableOption "modules.homeManager.programs.eza";

  config = lib.mkIf config.modules.homeManager.programs.eza.enable {
    # The local 'home.shellAliases' variables are not replaced with the arguably
    # simpler
    #
    #     home.shellAliases.<ALIAS_2> = config.home.shellAliases.<ALIAS_1>;
    #
    # statement to prevent the following error:
    #
    #     error: infinite recursion encountered
    home.shellAliases = let
      eza = pkgs.eza.pname;
    in {
      l = eza;
      la = "${eza} --all";
      ll = "${eza} --long";
      lla = "${eza} --all --long";
    };

    programs.eza.enable = true;
  };
}
