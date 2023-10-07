local api = vim.api
local keymap = vim.keymap
local db = require('dashboard')

db.custom_header = {
    ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
    ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
    ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
    ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
    ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
    ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝'
}

db.custom_center = {
    { icon = '  ',
        desc = 'Recently opened files                   ',
        action = 'lua require\'telescope.builtin\'.oldfiles{}',
        shortcut = 'SPC p h' },
    { icon = '  ',
        desc = 'Find  File                              ',
        action = 'lua require\'telescope.builtin\'.find_files{}',
        shortcut = 'SPC p f' },
    { icon = '  ',
        desc = 'File Browser                            ',
        action = 'Ex',
        shortcut = 'SPC p b' },
    { icon = '  ',
        desc = 'Find  word                              ',
        action = 'lua require\'telescope.builtin\'.live_grep{}',
        shortcut = 'SPC p g' },
    {
        icon = "  ",
        desc = "New file                                ",
        action = "enew",
        shortcut = "e      ",
    },
    {
        icon = "  ",
        desc = "Quit Nvim                               ",
        action = "qa",
        shortcut = "q      ",
    }
}

api.nvim_create_autocmd("FileType", {
    pattern = "dashboard",
    group = api.nvim_create_augroup("dashboard_enter", { clear = true }),
    callback = function()
        keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
        keymap.set("n", "e", ":enew<CR>", { buffer = true, silent = true })
    end
})

