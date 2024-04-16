lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "allowUnfree" {
  config.modules.homeManager.nixpkgs.config.allowUnfree.enable = true;

  imports = [
    ../../../../../../../modules/homeManager/nixpkgs/config/allowUnfree
  ];
}
