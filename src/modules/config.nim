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

proc get_config*(): Config =
    var arg = initOptParser(commandLineParams())
    var css = true
    var favicon = true
    var background = true
    var path = ""
    var docs_path = ""

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
                docs_path = arg.val
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
    
    Config(path:path, css:css, favicon:favicon, background:background, docs_path:docs_path)