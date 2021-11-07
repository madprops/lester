import std/[os, terminal, strutils, strformat]
import paths
import config

# Get the config object
get_config()

# Show docs path
let p = conf().docs_path.replace(gethomedir(), "~/")
echo &"\n{ansiForegroundColorCode(fgBlue)}Docs Path:{ansiResetCode} {p}"

# If no path then show
# the selection menu
if conf().paths.len() == 0:
    conf().paths = ask_paths()
    echo ""

# Process each path
for path in conf().paths:
    process_path(path)

echo ""