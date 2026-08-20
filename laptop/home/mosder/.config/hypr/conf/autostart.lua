local vars = require("conf.vars")

hl.on("hyprland.start", function()
    -- Scripts
    hl.exec_cmd(vars.scripts_dir .. "/randomize-wallpaper.sh")
    hl.exec_cmd(vars.scripts_dir .. "/battery-notifier.sh")
end)
