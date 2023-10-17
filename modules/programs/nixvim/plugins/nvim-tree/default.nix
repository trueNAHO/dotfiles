{
  programs.nixvim = {
    keymaps = [
      {
        action = "require('nvim-tree.api').tree.toggle";
        key = "<leader>e";
        lua = true;
        mode = "n";
        options.silent = true;
      }
    ];

    plugins.nvim-tree.enable = true;
  };
}
