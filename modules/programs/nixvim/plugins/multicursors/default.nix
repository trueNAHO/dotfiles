{
  programs.nixvim = {
    keymaps = [
      {
        action = "vim.cmd.MCstart";
        key = "<leader>v";
        lua = true;
        mode = "n";
        options.silent = true;
      }
    ];

    plugins.multicursors = {
      enable = true;
      extraOptions.hint_config = false;
    };
  };
}
