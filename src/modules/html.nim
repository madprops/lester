import config
import markdown
import strformat
import strutils
import nre

proc get_html*(conf: Config): string =
    let content = readFile(conf.path)
    var title = ""
    var lines: seq[string]
    
    for line in content.splitlines():
        let ls = line.strip()
        if ls.tolower().startswith("title:"):
            title = ls.replace(re"^(?i)title:", "")
        else:
            lines.add(line)
            
    var md = markdown(lines.join("\n"))

    md = &"<div id='container'>{md}</div><div id='footer'></div>"

    if conf.background:
        md = &"<div id='background'></div>{md}"
        
    if conf.css:
        let style = "<link rel='stylesheet' type='text/css' href='../extra/css/style.css'>"
        md = &"{style}{md}"
    
    if conf.favicon:
        let favicon = "<link rel='icon' type='text/css' href='../extra/img/favicon.png'>"
        md = &"{favicon}{md}"
    
    if title != "":
        md = &"<title>{title}</title>{md}"
        
    &"<!DOCTYPE html><meta charset='utf-8'>{md}"