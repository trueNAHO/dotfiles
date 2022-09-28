-- Modes when using an arrow keys to navigate is not beneficial.
local arrow_key_modes = {"i", "n", "o", "t", "v"}

-- Call this function when using an arrow key to navigate.
local function arrow_key()
    print("No gamer uses arrow keys. Neither should you.")
end

-- Set arrow keys.
vim.keymap.set(arrow_key_modes, "<down>", arrow_key)
vim.keymap.set(arrow_key_modes, "<left>", arrow_key)
vim.keymap.set(arrow_key_modes, "<right>", arrow_key)
vim.keymap.set(arrow_key_modes, "<up>", arrow_key)
