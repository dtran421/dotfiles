local wilder = require('wilder')
wilder.setup({ modes = { ':', '/', '?' } })

local gradient = {
	'#F746B3','#F74DAC','#F755A5','#F85C9E',
	'#F86497','#F86B90','#F87389','#F87A82',
	'#F9827C','#F98975','#F9916E','#F99867',
	'#F9A060','#FAA759','#FAAF52','#FAB64B'
}

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline(),
    wilder.search_pipeline()
  ),
})

for i, fg in ipairs(gradient) do
  gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Pmenu', {{a = 1}, {a = 1}, {foreground = fg}})
end

wilder.set_option('renderer', wilder.popupmenu_renderer({
  highlights = {
    gradient = gradient, -- must be set
    -- selected_gradient key can be set to apply gradient highlighting for the selected candidate.
    selected_gradient = gradient,
  },
  -- highlighter applies highlighting to the candidates
  highlighter = wilder.highlighter_with_gradient({
      wilder.basic_highlighter(),
  }),
  left = {' ', wilder.popupmenu_devicons()},
  right = {' ', wilder.popupmenu_scrollbar()},
  pumblend = 0,
}))
