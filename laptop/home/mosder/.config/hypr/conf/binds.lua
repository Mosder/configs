local vars = require 'conf.vars'

-- Brightness controls
hl.bind(
  'XF86MonBrightnessUp',
  hl.dsp.exec_cmd('brightnessctl set 5%+; ' .. vars.scripts_dir .. '/current-brightness.sh | xargs ' .. vars.osd .. '-client --brightness'),
  { locked = true, repeating = true }
)
hl.bind(
  'XF86MonBrightnessDown',
  hl.dsp.exec_cmd('brightnessctl set 5%-; ' .. vars.scripts_dir .. '/current-brightness.sh | xargs ' .. vars.osd .. '-client --brightness'),
  { locked = true, repeating = true }
)
