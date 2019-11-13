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
writeFile(&"../docs/render/pages/{fname}", render)

echo &"\n{ansiForegroundColorCode(fgGreen)}File saved as: {fname}{ansiResetCode}"
echo &"CSS Applied: {conf.css}"
echo &"Favicon Applied: {conf.favicon}"
echo &"Background Applied: {conf.background}"
echo ""