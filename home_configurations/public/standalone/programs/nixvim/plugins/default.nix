{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/prependPrefix {
  inherit inputs pkgs system;

  files = [
    ./comment-nvim
    ./debugprint
    ./fidget
    ./gitmessenger
    ./gitsigns
    ./illuminate
    ./leap
    ./lsp
    ./lsp-format
    ./nvim-colorizer
    ./nvim-tree
    ./rainbow-delimiters
    ./rustaceanvim
    ./spider
    ./surround
    ./telescope
    ./todo-comments
    ./treesitter
    ./treesitter-context
    ./trouble
    ./undotree
    ./wtf
  ];

  prefix = "plugins";
}
