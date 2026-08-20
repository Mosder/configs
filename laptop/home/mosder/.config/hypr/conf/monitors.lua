local monitors = {
    main = "eDP-1",
}

hl.monitor({ output = monitors.main, mode = "highres", position = "auto", scale = 1 })
hl.monitor({ output = "",            mode = "highres", position = "auto", scale = 1, mirror = monitors.main })

-- Returned so that conf/rules.lua can bind workspaces to these monitors
return monitors
