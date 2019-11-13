import os
import strutils
import strformat
import parseopt

type Config* = object
    path*: string
    css*: bool
    favicon*: bool
    background*: bool

proc get_config*(): Config =
    var arg = initOptParser(commandLineParams())
    var css = true
    var favicon = true
    var background = true
    var path = ""

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
        of cmdArgument:
            path = arg.key.strip()
        else: discard
    
    if path != "" and not path.contains("/"):
        path = &"../docs/templates/{path}"
    
    echo path
    
    Config(path:path, css:css, favicon:favicon, background:background)