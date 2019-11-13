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

proc ask_path*(): string =
    echo "\nChoose a template to compile\n"

    var files: seq[TFile]

    for file in walkdir("templates"):
        let info = getFileInfo(file.path)
        files.add(TFile(path:file.path, last_modified:info.lastWriteTime.toUnix()))

    files = files.sortedByIt(it.last_modified).reversed()

    var n = 1
    var paths = initTable[string, TFile]()

    for file in files:
        paths[intToStr(n)] = file
        echo &"{ansiForegroundColorCode(fgBlue)}({n}){ansiResetCode} {file.path}"
        inc(n); if n > 10: break

    echo ""

    var ans = "none"

    while true:
        ans = readLine(stdin)
        if paths.hasKey(ans):
            break

    paths[ans].path
