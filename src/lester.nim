import modules/paths
import modules/config
import modules/html
import os
import terminal
import strformat
import strutils

var conf = get_config()

if conf.path == "":
    conf.path = ask_path(conf)

let render = get_html(conf)
let fname = extractFileName(conf.path).changeFileExt("html")
var rpath = joinpath(conf.docs_path, "render/pages")

try:
    writeFile(joinpath(rpath, fname), render)
except:
    echo "Can't save the file."
    quit(0)

echo &"\n{ansiForegroundColorCode(fgGreen)}File saved as: {fname}{ansiResetCode}"
echo &"Docs Path: {$conf.docs_path.replace(gethomedir(), \"~/\")}"
echo &"CSS Applied: {conf.css}"
echo &"Favicon Applied: {conf.favicon}"
echo &"Background Applied: {conf.background}"
echo ""