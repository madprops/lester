import modules/paths
import modules/config
import modules/html
import os
import terminal
import strformat

var conf = get_config()

if conf.path == "":
    conf.path = ask_path()

let render = get_html(conf)
let fname = extractFileName(conf.path).changeFileExt("html")
var rpath = joinpath(gethomedir(), ".config/lester/docs/render/pages")

try:
    writeFile(joinpath(rpath, fname), render)
except:
    echo "Can't save the file."
    quit(0)

echo &"\n{ansiForegroundColorCode(fgGreen)}File saved as: {fname}{ansiResetCode}"
echo &"CSS Applied: {conf.css}"
echo &"Favicon Applied: {conf.favicon}"
echo &"Background Applied: {conf.background}"
echo ""