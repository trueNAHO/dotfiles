lib: let
  name = "plugins";
in
  (lib.dotfiles.homeManagerConfiguration.prependPrefix name [
    ./codeium-nvim
    ./codeium-vim
    ./nvim-cmp
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
