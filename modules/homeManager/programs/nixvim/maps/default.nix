{config, ...}: {
  programs.nixvim.maps = config.nixvim.helpers.mkMaps {silent = true;} {
    normal = {
      "<C-d>".action = "<C-d>zz";
      "<C-u>".action = "<C-u>zz";
      "<M-C-h>".action = "<C-w><";
      "<M-C-j>".action = "<C-w>+";
      "<M-C-k>".action = "<C-w>-";
      "<M-C-l>".action = "<C-w>>";
      "<leader>s".action = " <cmd>lua local spell = not vim.opt.spell:get() vim.opt.spell = spell print(spell)<cr>";
      "N".action = "Nzzzv";
      "n".action = "nzzzv";
    };

    normalVisualOp = {
      "<leader>D".action = "\"_D";
      "<leader>P".action = "\"_dP";
      "<leader>Y".action = "\"+Y";
      "<leader>d".action = "\"_d";
      "<leader>p".action = "\"_dP";
      "<leader>y".action = "\"+y";
    };
  };
}
