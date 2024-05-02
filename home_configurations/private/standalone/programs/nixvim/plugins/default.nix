lib: let
  name = "plugins";
in
  (lib.dotfiles.homeManagerConfiguration.prependPrefix name [
    ./cmp
    ./codeium-nvim
    ./codeium-vim
  ])
  // (lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration name {
    config.modules.programs.nixvim = {
      enable = true;
      plugins.full = true;
    };

    imports = [
      ../../../../../../modules/programs/nixvim
      ../../../../../../modules/programs/nixvim/plugins
    ];
  })
