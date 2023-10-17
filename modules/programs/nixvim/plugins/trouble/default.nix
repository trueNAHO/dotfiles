{
  programs.nixvim = {
    keymaps = [
      {
        action = "require('trouble').toggle";
        key = "<leader>ll";
        lua = true;
        mode = "n";
        options.silent = true;
      }
    ];

    plugins.trouble.enable = true;
  };
}
