{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.keymaps.enable =
    lib.mkEnableOption "modules.programs.nixvim.keymaps";

  config = lib.mkIf config.modules.programs.nixvim.keymaps.enable {
    programs.nixvim.keymaps =
      map (keymaps: {options.silent = true;} // keymaps)
      ((map (keymaps: {mode = "n";} // keymaps) ([
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
              key = "<M-C-k>";
            }

            {
              action = "<C-w>-";
              key = "<M-C-j>";
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
              action = "<C-w>W";
              key = "<leader>k";
            }

            {
              action = "<C-w>_<C-w>|";
              key = "<leader>F";
            }

            {
              action = "<C-w>c";
              key = "<leader>Q";
            }

            {
              action = "<C-w>w";
              key = "<leader>j";
            }

            {
              action = "Nzzzv";
              key = "N";
            }

            {
              action = ''
                function()
                  local spell = not vim.opt.spell:get()
                  vim.opt.spell = spell
                  print(spell)
                end
              '';

              key = "<leader>s";
              lua = true;
            }

            {
              action = ''
                function()
                  local virtual_text = not vim.diagnostic.config().virtual_text
                  vim.diagnostic.config({ virtual_text = virtual_text })
                  print(virtual_text)
                end
              '';

              key = "<leader>v";
              lua = true;
            }

            {
              action = "nzzzv";
              key = "n";
            }
          ]
          ++ (let
            insert_blank_line = line: ''
              local lines = {}

              for _ = 1, vim.v.count1 do
                table.insert(lines, "")
              end

              local line = ${line}

              vim.api.nvim_buf_set_lines(0, line, line, true, lines)
            '';
          in [
            {
              action = ''
                function()
                  ${insert_blank_line "vim.fn.line('.') - 1"}
                end
              '';

              key = "<leader>O";
              lua = true;
            }

            {
              action = ''
                function()
                  ${insert_blank_line "vim.fn.line('.')"}
                end
              '';

              key = "<leader>o";
              lua = true;
            }
          ])))
        ++ (map (keymaps: {mode = ["n" "v"];} // keymaps) [
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
        ]));
  };
}
