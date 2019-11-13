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
    md = &"<div id='container' class='{conf.container_class}'>{md}</div><div id='footer' class='{conf.footer_class}'></div>"

    # Add optional background
    if conf.background:
        md = &"<div id='background' class='{conf.background_class}'></div>{md}"
    
    # Add optional css
    if conf.css:
        let style = &"<link rel='stylesheet' type='text/css' href='../extra/css/style{conf.style_suffix}.css'>\n"
        md = &"{style}{md}"
    
    # Add optional favicon
    if conf.favicon:
        let favicon = &"<link rel='icon' type='text/css' href='../extra/img/favicon{conf.favicon_suffix}.png'>\n"
        md = &"{favicon}{md}"
    
    # Set the title
    if title != "":
        md = &"<title>{title}</title>\n{md}"
    
    # Add other metadata and return string
    &"<!DOCTYPE html>\n<meta charset='utf-8'>\n{md}"