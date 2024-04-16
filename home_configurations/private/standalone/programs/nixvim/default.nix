lib: let
  name = "nixvim";
in
  (lib.dotfiles.homeManagerConfiguration.prependPrefix name [./plugins])
  // (lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration name {
    config.modules.programs.nixvim.enable = true;
    imports = [../../../../../modules/programs/nixvim];
  })
