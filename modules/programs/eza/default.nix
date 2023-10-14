{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.eza.enable = lib.mkEnableOption "eza";

  config = lib.mkIf config.modules.programs.eza.enable {
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
