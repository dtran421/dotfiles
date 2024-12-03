local api = vim.api
local keymap = vim.keymap
local db = require('dashboard')

db.setup {
    theme = 'doom',
    config = {
        header = {
            '                                                       ',
            '                                                       ',
            '                                                       ',
            ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
            ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
            ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
            ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
            ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
            ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
            '                                                       ',
            '                                                       ',
        },
        center = {
            { 
                icon = '  ',
                desc = 'Recent files',
                action = 'lua require\'telescope.builtin\'.oldfiles{}',
                key = 'SPC p h',
                key_format = ' %s',
            },
            { 
                icon = '  ',
                desc = 'Find File',
                action = 'lua require\'telescope.builtin\'.find_files{}',
                key = 'SPC p f', 
                key_format = ' %s',
            },
            { 
                icon = '  ',
                desc = 'File Browser',
                action = 'Ex',
                key = 'SPC p b',
                key_format = ' %s',
            },
            { 
                icon = '  ',
                desc = 'Find Word',
                action = 'lua require\'telescope.builtin\'.live_grep{}',
                key = 'SPC p s',
                key_format = ' %s',
            },
            {
                icon = '  ',
                desc = 'New file',
                action = 'enew',
                key = 'e',
                key_format = ' %s',
            },
            {
                icon = '  ',
                desc = 'Quit Nvim',
                action = 'qa',
                key = 'q',
                key_format = ' %s',
            },
        },
        footer = {}
    },
}

api.nvim_create_autocmd('FileType', {
    pattern = 'dashboard',
    group = api.nvim_create_augroup('dashboard_enter', { clear = true }),
    callback = function()
        keymap.set('n', 'q', ':qa<CR>', { buffer = true, silent = true })
        keymap.set('n', 'e', ':enew<CR>', { buffer = true, silent = true })
    end
})

