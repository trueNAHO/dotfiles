-- Heavily inspired by: https://github.com/ThePrimeagen/.dotfiles

local prefix = {
    desc = {
        ctrl_d = "<C-d>. ",
        ctrl_u = "<C-u>. ",
        d = "Delete. ",
        down = "<down>. ",
        left = "<left>. ",
        m_c_h = "<M-C-h>. ",
        m_c_j = "<M-C-j>. ",
        m_c_k = "<M-C-k>. ",
        m_c_l = "<M-C-l>. ",
        n = "Next. ",
        p = "Paste. ",
        right = "<right>. ",
        toggle_s = "Settings Spell. ",
        toggle_v = "Settings Virtual text. ",
        up = "<up>. ",
        y = "Yank. "
    },
    status = ":lua ",
    toggle = "<leader>s"
}

-- Modes when using an arrow keys to navigate is not beneficial.
local arrow_key_modes = { "i", "n", "o", "t", "v" }

-- Call this function when using an arrow key to navigate.
local function arrow_key()
    print("No gamer uses arrow keys. Neither should you.")
end

-- Set arrow keys.
vim.keymap.set(
    arrow_key_modes, "<down>", arrow_key,
    { desc = prefix.desc.down .. "Set arrow keys" }
)
vim.keymap.set(
    arrow_key_modes, "<left>", arrow_key,
    { desc = prefix.desc.left .. "Set arrow keys" }
)
vim.keymap.set(
    arrow_key_modes, "<right>", arrow_key,
    { desc = prefix.desc.right .. "Set arrow keys" }
)
vim.keymap.set(
    arrow_key_modes, "<up>", arrow_key,
    { desc = prefix.desc.up .. "Set arrow keys" }
)

-- Place the cursor at the center of the window after various operations.
vim.keymap.set(
    "n", "<C-d>", "<C-d>zz",
    {
        desc = prefix.desc.ctrl_d .. "Place the cursor at the center of the " ..
            "window after `<C-d>`"
    }
)
vim.keymap.set(
    "n", "<C-u>", "<C-u>zz",
    {
        desc = prefix.desc.ctrl_u .. "Place the cursor at the center of the " ..
            "window after `<C-u>`"
    }
)
vim.keymap.set(
    "n", "N", "Nzzzv",
    {
        desc = prefix.desc.n .. "Place the cursor at the center of the " ..
            "window after `N`"
    }
)
vim.keymap.set(
    "n", "n", "nzzzv",
    {
        desc = prefix.desc.n .. "Place the cursor at the center of the " ..
            "window after `n`"
    }
)

-- Resize windows.
vim.keymap.set(
    "n", "<M-C-h>", "<C-w><",
    {
        desc = prefix.desc.m_c_h .. "Decrease current window width by 1"
    }
)
vim.keymap.set(
    "n", "<M-C-j>", "<C-w>+",
    {
        desc = prefix.desc.m_c_j .. "Increase current window height by 1"
    }
)
vim.keymap.set(
    "n", "<M-C-k>", "<C-w>-",
    {
        desc = prefix.desc.m_c_k .. "Decrease current window height by 1"
    }
)
vim.keymap.set(
    "n", "<M-C-l>", "<C-w>>",
    {
        desc = prefix.desc.m_c_l .. "Increase current window width by 1"
    }
)

-- Delete without altering the unnamed register.
vim.keymap.set(
    { "n", "v" }, "<leader>D", '"_D',
    { desc = prefix.desc.d .. "Delete without altering the unnamed register" }
)
vim.keymap.set(
    { "n", "v" }, "<leader>d", '"_d',
    { desc = prefix.desc.d .. "Delete without altering the unnamed register" }
)

-- Paste without altering the unnamed register.
vim.keymap.set(
    "x", "<leader>p", '"_dP',
    { desc = prefix.desc.p .. "Paste without altering the unnamed register" }
)

-- Yank into selection register.
vim.keymap.set(
    { "n", "v" }, "<leader>Y", '"+Y',
    { desc = prefix.desc.y .. "Yank into selection register", remap = true }
)
vim.keymap.set(
    { "n", "v" }, "<leader>y", '"+y',
    { desc = prefix.desc.y .. "Yank into selection register" }
)

-- Toggle spell checking.
vim.keymap.set(
    "n", prefix.toggle .. "s",
    function()
        local new_value = not vim.o.spell
        vim.o.spell = new_value
        print(("%svim.o.spell = %s"):format(prefix.status, new_value))
    end,
    { desc = prefix.desc.toggle_s .. "Toggle spell checking" }
)

-- Toggle virtual text.
vim.keymap.set("n", prefix.toggle .. "v",
    function()
        local new_value = not vim.diagnostic.config().virtual_text
        vim.diagnostic.config({ virtual_text = new_value })
        print(("%svim.diagnostic.config({ virtual_text = %s })"):format(
            prefix.status, new_value)
        )
    end,
    { desc = prefix.desc.toggle_v .. "Toggle virtual text" }
)
