import os
import strutils
import strformat
import parseopt

type Config* = object
    paths*: seq[string]
    css*: bool
    favicon*: bool
    background*: bool
    footer*: bool
    docs_path*: string
    file_name*: string
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
    var footer = true
    var paths: seq[string]
    var spaths: seq[string]
    var docs_path = ""
    var file_name = ""
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
            if arg.key == "no-footer":
                footer = false
            if arg.key == "docs-path":
                docs_path = arg.val.strip()
            if arg.key == "name":
                file_name = arg.val.strip()
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
            spaths.add(arg.key.strip())
        else: discard
    
    if docs_path == "":
        docs_path = joinpath(gethomedir(), &".config/lester/docs")
    else:
        if not docs_path.startswith("/"):
            docs_path = joinpath(getCurrentDir(), docs_path)
    
    for path in spaths:
        var p = path
        if p == "": continue
        if not p.contains("/"):
            p = joinpath(docs_path, &"templates/{path}")
        paths.add(p)
    
    Config(paths:paths, css:css, favicon:favicon, background:background, footer:footer,
    docs_path:docs_path, file_name:file_name, style_suffix:style_suffix, 
    favicon_suffix:favicon_suffix, container_class:container_class, 
    background_class:background_class, footer_class:footer_class)