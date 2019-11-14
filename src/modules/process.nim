import config
import render
import os
import terminal
import strformat
import strutils

proc process_path*(conf: Config, path: string) =
    # Render the markdown
    let html = markdown_to_html(conf, path)

    var fname = ""

    # Get the proper output file name
    if conf.file_name != "":
        fname = conf.file_name
    else:
        fname = extractFileName(path)

    # Add html extension
    fname = fname.changeFileExt("html")

    var rpath = joinpath(conf.docs_path, "render/pages")

    try:
        # Save the html render
        writeFile(joinpath(rpath, fname), html)
    except:
        echo "Can't save the file."
        quit(0)

    # Feedback on completion
    echo &"\n{ansiForegroundColorCode(fgGreen)}File saved as: {fname}{ansiResetCode}"
    echo &"Docs Path: {$conf.docs_path.replace(gethomedir(), \"~/\")}"