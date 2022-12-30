local db = require('dashboard')
local home = os.getenv('HOME')

db.custom_header = {
     ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
     ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
     ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
     ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
     ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
     ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝'
}

  db.custom_center = {
      {icon = '  ',
      desc = 'Recently opened files                   ',
      action =  'lua require\'telescope.builtin\'.oldfiles{}',
      shortcut = 'SPC p h'},
      {icon = '  ',
      desc = 'Find  File                              ',
      action = 'lua require\'telescope.builtin\'.find_files{}',
      shortcut = 'SPC p f'},
      {icon = '  ',
      desc ='File Browser                            ',
      action =  'Ex',
      shortcut = 'SPC p b'},
      {icon = '  ',
      desc = 'Find  word                              ',
      action = 'lua require\'telescope.builtin\'.live_grep{}',
      shortcut = 'SPC p g'},
 }
