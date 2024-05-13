{
  config,
  lib,
  ...
}: {
  imports = [../codeium-nvim ../lsp];

  options.dotfiles.programs.nixvim.plugins.cmp.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.cmp";

  config = lib.mkIf config.dotfiles.programs.nixvim.plugins.cmp.enable {
    dotfiles.programs.nixvim.plugins = {
      codeium-nvim.enable = true;
      lsp.enable = true;
    };

    programs.nixvim.plugins = {
      luasnip.enable = true;

      cmp = {
        enable = true;

        settings = {
          mapping = let
            scrollDelta = "4";
          in {
            "<C-b>" = ''
              cmp.mapping(function(fallback)
                local luasnip = require('luasnip')

                if luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';

            "<C-d>" = "cmp.mapping.scroll_docs(${scrollDelta})";
            "<C-e>" = "cmp.mapping.abort()";

            "<C-f>" = ''
              cmp.mapping(function(fallback)
                local luasnip = require('luasnip')

                if luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()

                elseif has_words_before() then
                  cmp.complete()

                else
                  fallback()
                end
              end, { "i", "s" })
            '';

            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-u>" = "cmp.mapping.scroll_docs(-${scrollDelta})";
            "<C-y>" = "cmp.mapping.confirm()";
            "<Down>" = "cmp.mapping.select_next_item()";
            "<Up>" = "cmp.mapping.select_prev_item()";
          };

          mappingPresets = ["insert"];
          snippet.expand = "luasnip";

          sources = [
            {name = "codeium";}
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "path";}
            {name = "buffer";}
          ];

          window = {
            completion.border = "rounded";
            documentation.border = "rounded";
          };
        };
      };
    };
  };
}
