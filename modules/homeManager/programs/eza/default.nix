{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.programs.eza.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.eza";

  config = lib.mkIf config.dotfiles.homeManager.programs.eza.enable {
    # The local 'home.shellAliases' variables are not replaced with the arguably
    # simpler
    #
    #     home.shellAliases.<ALIAS_2> = config.home.shellAliases.<ALIAS_1>;
    #
    # statement to prevent the following error:
    #
    #     error: infinite recursion encountered
    #
    # TODO: Patch an upstream fix.
    home.shellAliases = let
      eza = lib.getExe config.programs.eza.package;
    in {
      l = eza;
      la = "${eza} --all";
      ll = "${eza} --long";
      lla = "${eza} --all --long";
    };

    programs.eza.enable = true;
  };
}
