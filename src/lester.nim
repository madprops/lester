import modules/paths
import modules/config
import modules/process

# Get the config object
var conf = get_config()

# If no path then show
# the selection menu
if conf.paths.len() == 0:
    conf.paths = ask_paths(conf)

for path in conf.paths:
    process_path(conf, path)

echo ""