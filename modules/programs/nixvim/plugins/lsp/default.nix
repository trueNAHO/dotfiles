let
  leader = "<leader>l";
in {
  programs.nixvim.plugins.lsp = {
    enable = true;

    keymaps = {
      diagnostic = {
        "[d" = "goto_next";
        "]d" = "goto_prev";
      };

      lspBuf = {
        "${leader}a" = "code_action";
        "${leader}i" = "implementation";
        "${leader}r" = "rename";
        "${leader}t" = "type_definition";
        K = "hover";
        gD = "references";
        gd = "definition";
      };

      silent = true;
    };

    servers = {
      nil_ls.enable = true;
    };
  };
}