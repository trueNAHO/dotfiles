{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.lsp.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.lsp";

  config = lib.mkIf config.modules.programs.nixvim.plugins.lsp.enable {
    programs.nixvim.plugins.lsp = {
      enable = true;

      keymaps = {
        diagnostic = {
          "[d" = "goto_prev";
          "]d" = "goto_next";
        };

        lspBuf = let
          leader = "<leader>l";
        in {
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
        bashls.enable = true;
        html.enable = true;
        jsonls.enable = true;
        nil_ls.enable = true;
        ruff-lsp.enable = true;
        yamlls.enable = true;
      };
    };
  };
}
