let
  leader = "<leader>l";
in {
  programs.nixvim.plugins.lsp = {
    enable = true;

    keymaps = {
      diagnostic = {
        "[d" = "goto_prev";
        "]d" = "goto_next";
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
      html.enable = true;
      jsonls.enable = true;
      nil_ls.enable = true;
      pyright.enable = true;
      yamlls.enable = true;
    };
  };
}
