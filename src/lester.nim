import modules/paths
import modules/config
import modules/render
import os
import terminal
import strformat
import strutils

# Get the config object
var conf = get_config()

# If no path then show
# the selection menu
if conf.path == "":
    conf.path = ask_path(conf)

# Render the markdown
let html = markdown_to_html(conf)
let fname = extractFileName(conf.path).changeFileExt("html")
var rpath = joinpath(conf.docs_path, "render/pages")

try:
    # Save the html render
    writeFile(joinpath(rpath, fname), html)
except:
    echo "Can't save the file."
    quit(0)

# Stats feedback on completion
echo &"\n{ansiForegroundColorCode(fgGreen)}File saved as: {fname}{ansiResetCode}"
echo &"Docs Path: {$conf.docs_path.replace(gethomedir(), \"~/\")}"
echo &"CSS Applied: {conf.css}"
echo &"Favicon Applied: {conf.favicon}"
echo &"Background Applied: {conf.background}"
echo ""