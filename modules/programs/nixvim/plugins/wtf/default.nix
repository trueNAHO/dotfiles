{
  programs.nixvim = {
    keymaps = [
      {
        action = "function() require('wtf').search('duck_duck_go') end";
        key = "<leader>ls";
        lua = true;
        mode = "n";
        options.silent = true;
      }
    ];

    plugins.wtf.enable = true;
  };
}
