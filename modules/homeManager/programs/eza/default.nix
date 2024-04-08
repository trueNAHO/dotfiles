{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.eza.enable =
    lib.mkEnableOption "modules.homeManager.programs.eza";

  config = lib.mkIf config.modules.homeManager.programs.eza.enable {
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
