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
vim.keymap.set(arrow_key_modes, "<down>", arrow_key)
vim.keymap.set(arrow_key_modes, "<left>", arrow_key)
vim.keymap.set(arrow_key_modes, "<right>", arrow_key)
vim.keymap.set(arrow_key_modes, "<up>", arrow_key)

-- Place the cursor at the center of the window after various operations.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")

-- Delete without altering the unnamed register.
vim.keymap.set({ "n", "v" }, "<leader>D", '"_D')
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- Paste without altering the unnamed register.
vim.keymap.set("x", "<leader>p", '"_dP')

-- Yank into selection register.
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', { remap = true })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')

-- Toggle spell checking.
vim.keymap.set("n", toggle_prefix .. "s", function()
    local new_value = not vim.o.spell
    vim.o.spell = new_value
    print(("%svim.o.spell = %s"):format(status_prefix, new_value))
end)

-- Toggle virtual text.
vim.keymap.set("n", toggle_prefix .. "v", function()
    local new_value = not vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = new_value })
    print(("%svim.diagnostic.config({ virtual_text = %s })"):format(
        status_prefix, new_value)
    )
end)
