{
  programs.nixvim.plugins.gitsigns = {
    enable = true;

    # https://github.com/lewis6991/gitsigns.nvim/blob/287fffb410ce82d19da2d503a1f1570adf7b7874/README.md
    onAttach.function = let
      leader = "<leader>g";
    in ''
      function(bufnr)
        local gitsigns = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gitsigns.next_hunk() end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gitsigns.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "${leader}A", gitsigns.stage_hunk)
        map("n", "${leader}R", gitsigns.reset_hunk)
        map("n", "${leader}d", gitsigns.preview_hunk)
        map("n", "${leader}r", gitsigns.reset_buffer)
        map("n", "${leader}u", gitsigns.undo_stage_hunk)

        map("v", "${leader}a", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map("v", "${leader}r", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map({ "o", "x" }, "ih", "<cmd><C-U>Gitsigns select_hunk<cr>")
      end
    '';

    trouble = true;
  };
}
