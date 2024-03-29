import std/[os, strutils, strformat]
import pkg/nap

template `!`(x: bool): bool = not x

type Config* = ref object
  paths*: seq[string]
  css*: bool
  favicon*: bool
  background*: bool
  footer*: bool
  update*: bool
  docs_path*: string
  file_name*: string
  style_suffix*: string
  favicon_suffix*: string
  container_class*: string
  background_class*: string
  footer_class*: string
  additional_css*: string
  additional_js*: string

var oconf: Config

proc get_config*() =

  # Register arguments
  let css = add_arg(name="no-css", kind="flag", help="Disable css addition")
  let favicon = add_arg(name="no-favicon", kind="flag", help="Disable favicon addition")
  let background = add_arg(name="no-background", kind="flag", help="Disable background addition")
  let footer = add_arg(name="no-footer", kind="flag", help="Disable footer addition")
  let update = add_arg(name="update", kind="flag", help="Update existing rendered file")
  let file_name = add_arg(name="name", kind="value", help="Name of the output file")
  let docs_path = add_arg(name="docs-path", kind="value", help="Path to the docs directory")
  let style_suffix = add_arg(name="style-suffix", kind="value", help="Suffix for the css file name")
  let favicon_suffix = add_arg(name="favicon-suffix", kind="value", help="Suffix for the favicon file name")
  let container_class = add_arg(name="container-class", kind="value", help="Class for the container element")
  let background_class = add_arg(name="background-class", kind="value", help="Class for the background element")
  let footer_class = add_arg(name="footer-class", kind="value", help="Class for the footer element")
  let additional_css = add_arg(name="additional-css", kind="value", help="List of additional css files to include")
  let additional_js = add_arg(name="additional-js", kind="value", help="List of additional js files to include")
  let ppaths = add_arg(name="paths", kind="argument", help="Paths/Names for immidiate render")

  # Do the argument parsing
  add_header("lester - markdown to html converter")
  parse_args()

  # Raw Paths
  var rpaths: seq[string]
  
  if ppaths.used: 
    rpaths.add(ppaths.value)
    for p in get_argtail():
      rpaths.add(p)
  
  # Fix docs path
  if docs_path.value == "":
    docs_path.value = getConfigDir().joinPath("lester/docs")
  else:
    if not docs_path.value.startswith("/"):
      docs_path.value = joinpath(getCurrentDir(), docs_path.value)
  
  # Hold fixed paths
  var paths: seq[string]
  
  # Fix paths
  for path in rpaths:
    var p = path
    if p == "": continue
    if not p.contains("/"):
      p = joinpath(docs_path.value, &"templates/{path}")
    paths.add(p)
  
  # Create config object
  oconf = Config(paths:paths, 
  css: !css.used, favicon: !favicon.used, background: !background.used, footer: !footer.used, 
  docs_path:docs_path.value, file_name:file_name.value, style_suffix:style_suffix.value, 
  favicon_suffix:favicon_suffix.value, container_class:container_class.value, 
  background_class:background_class.value, footer_class:footer_class.value,
  update:update.used, additional_css:additional_css.value, additional_js:additional_js.value)

proc conf*(): Config =
  return oconf