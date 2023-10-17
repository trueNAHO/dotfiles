{
  programs.nixvim = {
    keymaps = [
      {
        action = "vim.cmd.UndotreeToggle";
        key = "<leader>u";
        lua = true;
        mode = "n";
        options.silent = true;
      }
    ];

    plugins.undotree.enable = true;
  };
}
