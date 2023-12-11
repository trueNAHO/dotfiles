{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.asciidoctor.enable =
    lib.mkEnableOption "asciidoctor";

  config = lib.mkIf config.modules.homeManager.home.packages.asciidoctor.enable {
    home.packages = [pkgs.asciidoctor-with-extensions];
  };
}
