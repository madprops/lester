import settings
import config
import os
import times
import tables
import strutils
import terminal
import strformat
import algorithm

type TFile = object
    path: string
    last_modified: int64

# Show a menu to let the user 
# select a file to render
proc ask_path*(conf: Config): string =
    echo "\nChoose a template to render"

    var files: seq[TFile]
    var tpath = joinpath(conf.docs_path, "templates")

    # Get template files
    for file in walkdir(tpath):
        let info = getFileInfo(file.path)
        files.add(TFile(path:file.path, last_modified:info.lastWriteTime.toUnix()))

    # Sort by modification date
    files = files.sortedByIt(it.last_modified).reversed()

    if files.len() == 0:
        echo "There are no templates."
        quit(0)
    
    echo "(q to exit)\n"

    var n = 1
    var paths = initTable[string, TFile]()

    # Print the menu
    for file in files:
        paths[intToStr(n)] = file
        echo &"{ansiForegroundColorCode(fgBlue)}({n}){ansiResetCode} {file.path.extractFileName()}"
        inc(n); if n > s_max_paths: break

    echo ""

    var ans = "none"

    while true:
        # Get user input
        ans = readLine(stdin).strip()
        # Exit character
        if ans == "q":
            quit(0)
        # Check if it's a valid number
        elif paths.hasKey(ans):
            break
    
    # Return the selected 
    # template path
    paths[ans].path
