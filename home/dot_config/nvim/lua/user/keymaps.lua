-- Heavily inspired by: https://github.com/ThePrimeagen/.dotfiles

local status_prefix = ":lua "
local toggle_prefix = "<leader>s"

-- Modes when using an arrow keys to navigate is not beneficial.
local arrow_key_modes = { "i", "n", "o", "t", "v" }

-- Call this function when using an arrow key to navigate.
local function arrow_key()
    print("No gamer uses arrow keys. Neither should you.")
end

-- Set arrow keys.
vim.keymap.set(
    arrow_key_modes, "<down>", arrow_key, { desc = "Set arrow keys" }
)
vim.keymap.set(
    arrow_key_modes, "<left>", arrow_key, { desc = "Set arrow keys" }
)
vim.keymap.set(
    arrow_key_modes, "<right>", arrow_key, { desc = "Set arrow keys" }
)
vim.keymap.set(
    arrow_key_modes, "<up>", arrow_key, { desc = "Set arrow keys" }
)

-- Place the cursor at the center of the window after various operations.
vim.keymap.set(
    "n", "<C-d>", "<C-d>zz",
    { desc = "Place the cursor at the center of the window after `<C-d>`" }
)
vim.keymap.set(
    "n", "<C-u>", "<C-u>zz",
    { desc = "Place the cursor at the center of the window after `<C-u>`" }
)
vim.keymap.set(
    "n", "N", "Nzzzv",
    { desc = "Place the cursor at the center of the window after `N`" }
)
vim.keymap.set(
    "n", "n", "nzzzv",
    { desc = "Place the cursor at the center of the window after `n`" }
)

-- Delete without altering the unnamed register.
vim.keymap.set(
    { "n", "v" }, "<leader>D", '"_D',
    { desc = "Delete without altering the unnamed register" }
)
vim.keymap.set(
    { "n", "v" }, "<leader>d", '"_d',
    { desc = "Delete without altering the unnamed register" }
)

-- Paste without altering the unnamed register.
vim.keymap.set(
    "x", "<leader>p", '"_dP',
    { desc = "Paste without altering the unnamed register" }
)

-- Yank into selection register.
vim.keymap.set(
    { "n", "v" }, "<leader>Y", '"+Y',
    { desc = "Yank into selection register", remap = true }
)
vim.keymap.set(
    { "n", "v" }, "<leader>y", '"+y',
    { desc = "Yank into selection register" }
)

-- Toggle spell checking.
vim.keymap.set(
    "n", toggle_prefix .. "s",
    function()
        local new_value = not vim.o.spell
        vim.o.spell = new_value
        print(("%svim.o.spell = %s"):format(status_prefix, new_value))
    end,
    { desc = "Toggle spell checking" }
)

-- Toggle virtual text.
vim.keymap.set("n", toggle_prefix .. "v",
    function()
        local new_value = not vim.diagnostic.config().virtual_text
        vim.diagnostic.config({ virtual_text = new_value })
        print(("%svim.diagnostic.config({ virtual_text = %s })"):format(
            status_prefix, new_value)
        )
    end,
    { desc = "Toggle virtual text" }
)
