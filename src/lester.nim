import modules/paths
import modules/config
import os
import terminal
import strutils
import strformat

# Get the config object
var conf = get_config()

# Show docs path
let p = conf.docs_path.replace(gethomedir(), "~/")
echo &"\n{ansiForegroundColorCode(fgBlue)}Docs Path:{ansiResetCode} {p}"

# If no path then show
# the selection menu
if conf.paths.len() == 0:
    conf.paths = ask_paths(conf)
    echo ""

# Process each path
for path in conf.paths:
    process_path(conf, path)

echo ""