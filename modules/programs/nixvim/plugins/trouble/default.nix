{
  programs.nixvim = {
    keymaps = [
      {
        action = ''
          function() require("trouble").toggle("workspace_diagnostics") end
        '';

        key = "<leader>ll";
        lua = true;
        mode = "n";
        options.silent = true;
      }
    ];

    plugins.trouble.enable = true;
  };
}
