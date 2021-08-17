import std/strformat
import std/strutils
import std/algorithm
import std/nre
import pkg/markdown
import config

# Transform the markdown to html
proc markdown_to_html*(path:string): string =
  var content = ""

  try:
    # Read the template file
    content = readFile(path)
  except:
    # If it fails then try 
    # adding an .md extension
    if not path.endswith(".md"):
      let p = &"{path}.md"
      try:
         content = readFile(p)
      except:
        echo &"\nCan't read {p}."
        echo "Maybe you mispelled it?"
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
  md = &"<div id='container' class='{conf().container_class}'>{md}</div>"

  # Add optional footer
  if conf().footer:
    md = &"{md}<div id='footer' class='{conf().footer_class}'></div>"

  # Add optional background
  if conf().background:
    md = &"<div id='background' class='{conf().background_class}'></div>{md}"

  # Include optional js files
  if conf().additional_js != "":
    let names = conf().additional_js.split(" ").reversed()
    for name in names:
      let n = name.strip()
      if n == "": continue
      let style = &"<script src='../extra/js/{n}.js'></script>\n"
      md = &"{style}{md}"
          
  # Include optional css files
  if conf().additional_css != "":
    let names = conf().additional_css.split(" ").reversed()
    for name in names:
      let n = name.strip()
      if n == "": continue
      let style = &"<link rel='stylesheet' type='text/css' href='../extra/css/{n}.css'>\n"
      md = &"{style}{md}"

  # Add optional css
  if conf().css:
    let style = &"<link rel='stylesheet' type='text/css' href='../extra/css/style{conf().style_suffix}.css'>\n"
    md = &"{style}{md}"

  # Add optional favicon
  if conf().favicon:
    let favicon = &"<link rel='icon' type='text/css' href='../extra/img/favicon{conf().favicon_suffix}.png'>\n"
    md = &"{favicon}{md}"

  # Set the title
  if title != "":
    md = &"<title>{title}</title>\n{md}"

  # Add other metadata and return string
  &"<!DOCTYPE html>\n<meta charset='utf-8'>\n{md}"