-- print("It works")

local M = {}

local buf = nil
local win = nil

local create_window = function()
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = (vim.o.lines - height) / 2
    local col = (vim.o.columns - width) / 2

    buf = vim.api.nvim_create_buf(false, true)
    win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    vim.api.nvim_win_set_option(win, "winhl", "Terminal:Terminal")

    return win
end

M.toggle = function()
    if win then
        vim.api.nvim_win_close(win, true)
        win = nil
        buf = nil
    else
        create_window()
        vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>lua require"floating-terminal".toggle()<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(buf, 't', '<Esc>', '<C-\\><C-n><cmd>lua require"floating-terminal".toggle()<CR>', { noremap = true, silent = true })
        vim.cmd('startinsert')
    end
end

M.setup = function()
    vim.keymap.set('n', '<leader>tt', '<cmd>lua require("floating-terminal").toggle()<CR>')
end

return M
