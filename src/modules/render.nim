import config
import markdown
import strformat
import strutils
import nre

# Transform the markdown to html
proc markdown_to_html*(conf: Config): string =
    var content = ""
    
    try:
        # Read the template file
        content = readFile(conf.path)
    except:
        # If it fails then try 
        # adding an .md extension
        if not conf.path.endswith(".md"):
            try:
                content = readFile(&"{conf.path}.md")
            except:
                echo "Can't read the file."
                quit(0)

    var title = ""
    var lines: seq[string]
    
    # Get metadata like title
    for line in content.splitlines():
        let ls = line.strip()
        if ls.tolower().startswith("title:"):
            title = ls.replace(re"^(?i)title:", "")
        else:
            lines.add(line)
    
    # Join all valid markdown lines
    var md = markdown(lines.join("\n"))

    # Add container and footer divs
    md = &"<div id='container'>{md}</div><div id='footer'></div>"

    # Add optional background
    if conf.background:
        md = &"<div id='background'></div>{md}"
    
    # Add optional css
    if conf.css:
        let style = "<link rel='stylesheet' type='text/css' href='../extra/css/style.css'>"
        md = &"{style}{md}"
    
    # Add optional favicon
    if conf.favicon:
        let favicon = "<link rel='icon' type='text/css' href='../extra/img/favicon.png'>"
        md = &"{favicon}{md}"
    
    # Set the title
    if title != "":
        md = &"<title>{title}</title>{md}"
    
    # Add other metadata and return string
    &"<!DOCTYPE html><meta charset='utf-8'>{md}"