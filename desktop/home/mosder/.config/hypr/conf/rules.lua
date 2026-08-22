local monitors = require 'conf.monitors'

-- Set default monitors for workspaces
hl.workspace_rule { workspace = '1', monitor = monitors.main, default = true }
hl.workspace_rule { workspace = '2', monitor = monitors.second, default = true }
hl.workspace_rule { workspace = '3', monitor = monitors.second }
hl.workspace_rule { workspace = '4', monitor = monitors.main }
hl.workspace_rule { workspace = '5', monitor = monitors.main }
