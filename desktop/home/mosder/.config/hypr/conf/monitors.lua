local monitors = {
  main = 'DP-1',
  second = 'HDMI-A-1',
}

hl.monitor { output = monitors.main, mode = '2560x1440@144', position = '0x0', scale = 1 }
hl.monitor { output = monitors.second, mode = '1920x1080@60', position = '2560x360', scale = 1 }

return monitors
