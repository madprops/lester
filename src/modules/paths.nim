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

proc ask_path*(conf: Config): string =
    echo "\nChoose a template to render"

    var files: seq[TFile]
    var tpath = joinpath(conf.docs_path, "templates")

    for file in walkdir(tpath):
        let info = getFileInfo(file.path)
        files.add(TFile(path:file.path, last_modified:info.lastWriteTime.toUnix()))

    files = files.sortedByIt(it.last_modified).reversed()

    if files.len() == 0:
        echo "There are no templates."
        quit(0)
    
    echo "(q to exit)\n"

    var n = 1
    var paths = initTable[string, TFile]()

    for file in files:
        paths[intToStr(n)] = file
        echo &"{ansiForegroundColorCode(fgBlue)}({n}){ansiResetCode} {file.path.extractFileName()}"
        inc(n); if n > 10: break

    echo ""

    var ans = "none"

    while true:
        ans = readLine(stdin).strip()
        if ans == "q":
            quit(0)
        if paths.hasKey(ans):
            break

    paths[ans].path
