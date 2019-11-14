import settings
import config
import render
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
proc ask_paths*(conf: Config): seq[string] =
    var files: seq[TFile]
    var tpath = joinpath(conf.docs_path, "templates")
    
    # Get template files
    for file in walkdir(tpath):
        if not file.path.endswith(".md"):
            continue
        let info = getFileInfo(file.path)
        files.add(TFile(path:file.path, last_modified:info.lastWriteTime.toUnix()))
        
    if files.len() == 0:
        echo "There are no templates in the directory."
        quit(0)

    # Sort by modification date
    files = files.sortedByIt(it.last_modified).reversed()
            
    echo "\nChoose the templates to render"
    echo "(Space separated)"
    let xquit = &"{ansiForegroundColorCode(fgBlue)}(q){ansiResetCode} Quit"
    let xall = &"{ansiForegroundColorCode(fgBlue)}(A){ansiResetCode} All"
    echo &"{xquit} | {xall}\n"

    var n = 1
    var paths = initTable[string, TFile]()

    # Print the menu
    for file in files:
        paths[intToStr(n)] = file
        echo &"{ansiForegroundColorCode(fgBlue)}({n}){ansiResetCode} {file.path.extractFileName()}"
        inc(n); if n > s_max_paths: break

    echo ""

    var pths: seq[string]

    block loop:
        while true:
            # Get user input
            var ans = readLine(stdin).strip()
            ans = ans.replace(",", " ")

            # Exit character
            if ans.toLower() == "q":
                quit(0)
            
            elif ans == "A":
                for key, val in paths:
                    pths.add(paths[key].path)
                break loop

            var ok = true
            let nums = ans.split(" ")
            var cnums: seq[string]

            for num in nums:
                var n = num.strip()
                if n == "":
                    continue
                if not paths.hasKey(n):
                    ok = false
                    break
                cnums.add(n)
            
            # Continue looping
            if not ok: continue

            # If valid add each path
            for num in cnums:
                pths.add(paths[num].path)
            break
        
    # Return the selected 
    # template paths
    return pths

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
    echo &"{ansiForegroundColorCode(fgGreen)}Rendered:{ansiResetCode} {fname}"