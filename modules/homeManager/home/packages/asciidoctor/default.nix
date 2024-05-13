{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.asciidoctor.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.asciidoctor";

  config =
    lib.mkIf
    config.dotfiles.homeManager.home.packages.asciidoctor.enable {
      home.packages = [pkgs.asciidoctor-with-extensions];
    };
}
