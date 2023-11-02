{
  programs.nixvim.keymaps =
    map (keymaps: keymaps // {options.silent = true;})
    (map (keymaps: keymaps // {mode = "n";}) [
      {
        action = "<C-d>zz";
        key = "<C-d>";
      }

      {
        action = "<C-u>zz";
        key = "<C-u>";
      }

      {
        action = "<C-w>+";
        key = "<M-C-j>";
      }

      {
        action = "<C-w>-";
        key = "<M-C-k>";
      }

      {
        action = "<C-w><";
        key = "<M-C-h>";
      }

      {
        action = "<C-w>>";
        key = "<M-C-l>";
      }

      {
        action = "Nzzzv";
        key = "N";
      }

      {
        action = "function() local spell = not vim.opt.spell:get() vim.opt.spell = spell print(spell) end";
        key = "<leader>s";
        lua = true;
      }

      {
        action = "nzzzv";
        key = "n";
      }
    ])
    ++ (map (keymaps: keymaps // {mode = ["n" "v"];}) [
      {
        action = ''"+Y'';
        key = "<leader>Y";
      }

      {
        action = ''"+y'';
        key = "<leader>y";
      }

      {
        action = ''"_D'';
        key = "<leader>D";
      }

      {
        action = ''"_d'';
        key = "<leader>d";
      }

      {
        action = ''"_dP'';
        key = "<leader>P";
      }

      {
        action = ''"_dP'';
        key = "<leader>p";
      }
    ]);
}
