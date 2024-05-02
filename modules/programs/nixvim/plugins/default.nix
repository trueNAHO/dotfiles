{
  config,
  lib,
  ...
}: {
  imports = [
    ./cmp
    ./codeium-nvim
    ./codeium-vim
    ./comment
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

  options.modules.programs.nixvim.plugins.full =
    lib.mkEnableOption "modules.programs.nixvim.plugins.full";

  config = lib.mkIf config.modules.programs.nixvim.plugins.full {
    modules.programs.nixvim.plugins = {
      cmp.enable = lib.mkDefault true;
      codeium-nvim.enable = lib.mkDefault true;
      codeium-vim.enable = lib.mkDefault true;
      comment.enable = lib.mkDefault true;
      debugprint.enable = lib.mkDefault true;
      fidget.enable = lib.mkDefault true;
      gitmessenger.enable = lib.mkDefault true;
      gitsigns.enable = lib.mkDefault true;
      illuminate.enable = lib.mkDefault true;
      leap.enable = lib.mkDefault true;
      lsp-format.enable = lib.mkDefault true;
      lsp.enable = lib.mkDefault true;
      nvim-colorizer.enable = lib.mkDefault true;
      nvim-tree.enable = lib.mkDefault true;
      rainbow-delimiters.enable = lib.mkDefault true;
      rustaceanvim.enable = lib.mkDefault true;
      spider.enable = lib.mkDefault true;
      surround.enable = lib.mkDefault true;
      telescope.enable = lib.mkDefault true;
      todo-comments.enable = lib.mkDefault true;
      treesitter-context.enable = lib.mkDefault true;
      treesitter.enable = lib.mkDefault true;
      trouble.enable = lib.mkDefault true;
      undotree.enable = lib.mkDefault true;
      wtf.enable = lib.mkDefault true;
    };
  };
}
