lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "asciidoctor" {
  config.modules.homeManager.home.packages.asciidoctor.enable = true;

  imports = [
    ../../../../../../../modules/homeManager/home/packages/asciidoctor
  ];
}
