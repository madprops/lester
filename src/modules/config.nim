import os
import strutils
import strformat
import parseopt

type Config* = object
    path*: string
    css*: bool
    favicon*: bool
    background*: bool
    docs_path*: string
    style_suffix*: string
    favicon_suffix*: string
    container_class*: string
    background_class*: string
    footer_class*: string

# Process arguments and
# build the config object
proc get_config*(): Config =
    var arg = initOptParser(commandLineParams())
    var css = true
    var favicon = true
    var background = true
    var path = ""
    var docs_path = ""
    var style_suffix = ""
    var favicon_suffix = ""
    var container_class = ""
    var background_class = ""
    var footer_class = ""

    while true:
        arg.next()
        case arg.kind
        of cmdEnd: break
        of cmdLongOption:
            if arg.key == "no-css":
                css = false
            if arg.key == "no-favicon":
                favicon = false
            if arg.key == "no-background":
                background = false
            if arg.key == "docs-path":
                docs_path = arg.val.strip()
            if arg.key == "style-suffix":
                style_suffix = arg.val.strip()
            if arg.key == "favicon-suffix":
                favicon_suffix = arg.val.strip()
            if arg.key == "container-class":
                container_class = arg.val.strip()
            if arg.key == "background-class":
                background_class = arg.val.strip()
            if arg.key == "footer-class":
                footer_class = arg.val.strip()
        of cmdArgument:
            path = arg.key.strip()
        else: discard
    
    if docs_path == "":
        docs_path = joinpath(gethomedir(), &".config/lester/docs")
    else:
        if not docs_path.startswith("/"):
            docs_path = joinpath(getCurrentDir(), docs_path)
    
    if path != "" and not path.contains("/"):
        path = joinpath(docs_path, &"templates/{path}")
    
    Config(path:path, css:css, favicon:favicon, background:background, docs_path:docs_path, 
    style_suffix:style_suffix, favicon_suffix:favicon_suffix, 
    container_class:container_class, background_class:background_class, footer_class:footer_class)