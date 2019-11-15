import os
import strutils
import strformat
import parseopt
import nap

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

    add_arg(name="no-css", kind="flag", help="Disable css addition")
    add_arg(name="no-favicon", kind="flag", help="Disable favicon addition")
    add_arg(name="no-background", kind="flag", help="Disable background addition")
    add_arg(name="no-footer", kind="flag", help="Disable footer addition")
    add_arg(name="docs-path", kind="value", help="Path to the docs directory")
    add_arg(name="name", kind="value", help="Name of the output file")
    add_arg(name="style-suffix", kind="value", help="Suffix for the css file name")
    add_arg(name="favicon-suffix", kind="value", help="Suffix for the favicon file name")
    add_arg(name="container-class", kind="value", help="Class for the container element")
    add_arg(name="background-class", kind="value", help="Class for the background element")
    add_arg(name="footer-class", kind="value", help="Class for the footer element")
    add_arg(name="paths", kind="argument", help="Paths/Names for immidiate render")

    parse_args("lester - markdown to html converter")
    
    css = not arg("no-css").used
    favicon = not arg("no-favicon").used
    background = not arg("no-background").used
    footer = not arg("no-footer").used
    
    var a1 = arg("docs-path")
    if a1.used: docs_path = a1.value
    
    var a2 = arg("name")
    if a2.used: file_name = a2.value
    
    var a3 = arg("style-suffix")
    if a3.used: style_suffix = a3.value
    
    var a4 = arg("favicon-suffix")
    if a4.used: favicon_suffix = a4.value
    
    var a5 = arg("container-class")
    if a5.used: container_class = a5.value
    
    var a6 = arg("background-class")
    if a6.used: background_class = a6.value
    
    var a7 = arg("footer-class")
    if a7.used: footer_class = a7.value
    
    var a8 = arg("paths")
    if a8.used: 
         spaths.add(a8.value)
         for p in argtail():
            spaths.add(p)
    
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