local vars = require("conf.vars")

hl.on("hyprland.start", function()
    -- Scripts
    hl.exec_cmd(vars.scripts_dir .. "/randomize-wallpapers.sh")

    -- Programs
    hl.dispatch(hl.dsp.exec_cmd(vars.steam, { workspace = "5 silent" }))
end)
