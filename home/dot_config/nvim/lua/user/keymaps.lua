-- Heavily inspired by: https://github.com/ThePrimeagen/.dotfiles

local prefix_status = ":lua "
local prefix_toggle = "<leader>s"

local prefix_desc_ctrl_d = "<C-d>. "
local prefix_desc_ctrl_u = "<C-u>. "
local prefix_desc_d = "Delete. "
local prefix_desc_down = "<down>. "
local prefix_desc_left = "<left>. "
local prefix_desc_m_c_h = "<M-C-h>. "
local prefix_desc_m_c_j = "<M-C-j>. "
local prefix_desc_m_c_k = "<M-C-k>. "
local prefix_desc_m_c_l = "<M-C-l>. "
local prefix_desc_n = "Next. "
local prefix_desc_p = "Paste. "
local prefix_desc_right = "<right>. "
local prefix_desc_toggle_s = "Settings Spell. "
local prefix_desc_toggle_v = "Settings Virtual text. "
local prefix_desc_up = "<up>. "
local prefix_desc_y = "Yank. "

-- Modes when using an arrow keys to navigate is not beneficial.
local arrow_key_modes = { "i", "n", "o", "t", "v" }

-- Call this function when using an arrow key to navigate.
local function arrow_key()
    print("No gamer uses arrow keys. Neither should you.")
end

-- Set arrow keys.
vim.keymap.set(
    arrow_key_modes, "<down>", arrow_key,
    { desc = prefix_desc_down .. "Set arrow keys" }
)
vim.keymap.set(
    arrow_key_modes, "<left>", arrow_key,
    { desc = prefix_desc_left .. "Set arrow keys" }
)
vim.keymap.set(
    arrow_key_modes, "<right>", arrow_key,
    { desc = prefix_desc_right .. "Set arrow keys" }
)
vim.keymap.set(
    arrow_key_modes, "<up>", arrow_key,
    { desc = prefix_desc_up .. "Set arrow keys" }
)

-- Place the cursor at the center of the window after various operations.
vim.keymap.set(
    "n", "<C-d>", "<C-d>zz",
    {
        desc = prefix_desc_ctrl_d .. "Place the cursor at the center of the " ..
            "window after `<C-d>`"
    }
)
vim.keymap.set(
    "n", "<C-u>", "<C-u>zz",
    {
        desc = prefix_desc_ctrl_u .. "Place the cursor at the center of the " ..
            "window after `<C-u>`"
    }
)
vim.keymap.set(
    "n", "N", "Nzzzv",
    {
        desc = prefix_desc_n .. "Place the cursor at the center of the " ..
            "window after `N`"
    }
)
vim.keymap.set(
    "n", "n", "nzzzv",
    {
        desc = prefix_desc_n .. "Place the cursor at the center of the " ..
            "window after `n`"
    }
)


-- Resize windows.
vim.keymap.set(
    "n", "<M-C-h>", "<C-w><",
    {
        desc = prefix_desc_m_c_h .. "Decrease current window width by 1"
    }
)
vim.keymap.set(
    "n", "<M-C-j>", "<C-w>+",
    {
        desc = prefix_desc_m_c_j .. "Increase current window height by 1"
    }
)
vim.keymap.set(
    "n", "<M-C-k>", "<C-w>-",
    {
        desc = prefix_desc_m_c_k .. "Decrease current window height by 1"
    }
)
vim.keymap.set(
    "n", "<M-C-l>", "<C-w>>",
    {
        desc = prefix_desc_m_c_l .. "Increase current window width by 1"
    }
)

-- Delete without altering the unnamed register.
vim.keymap.set(
    { "n", "v" }, "<leader>D", '"_D',
    { desc = prefix_desc_d .. "Delete without altering the unnamed register" }
)
vim.keymap.set(
    { "n", "v" }, "<leader>d", '"_d',
    { desc = prefix_desc_d .. "Delete without altering the unnamed register" }
)

-- Paste without altering the unnamed register.
vim.keymap.set(
    "x", "<leader>p", '"_dP',
    { desc = prefix_desc_p .. "Paste without altering the unnamed register" }
)

-- Yank into selection register.
vim.keymap.set(
    { "n", "v" }, "<leader>Y", '"+Y',
    { desc = prefix_desc_y .. "Yank into selection register", remap = true }
)
vim.keymap.set(
    { "n", "v" }, "<leader>y", '"+y',
    { desc = prefix_desc_y .. "Yank into selection register" }
)

-- Toggle spell checking.
vim.keymap.set(
    "n", prefix_toggle .. "s",
    function()
        local new_value = not vim.o.spell
        vim.o.spell = new_value
        print(("%svim.o.spell = %s"):format(prefix_status, new_value))
    end,
    { desc = prefix_desc_toggle_s .. "Toggle spell checking" }
)

-- Toggle virtual text.
vim.keymap.set("n", prefix_toggle .. "v",
    function()
        local new_value = not vim.diagnostic.config().virtual_text
        vim.diagnostic.config({ virtual_text = new_value })
        print(("%svim.diagnostic.config({ virtual_text = %s })"):format(
            prefix_status, new_value)
        )
    end,
    { desc = prefix_desc_toggle_v .. "Toggle virtual text" }
)
