import modules/paths
import modules/config
import modules/process
import os
import terminal
import strutils
import strformat

# Get the config object
var conf = get_config()

echo &"\n{ansiForegroundColorCode(fgBlue)}Docs Path: {ansiResetCode}",
    &"{$conf.docs_path.replace(gethomedir(), \"~/\")}"

# If no path then show
# the selection menu
if conf.paths.len() == 0:
    conf.paths = ask_paths(conf)
    echo ""

for path in conf.paths:
    process_path(conf, path)

echo ""