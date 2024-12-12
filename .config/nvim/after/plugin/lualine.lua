require('lualine').setup {
  options = {
    theme = 'catppuccin',
    component_separators = { left = ')', right = '('},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_x = {'filetype'},
  },
}

