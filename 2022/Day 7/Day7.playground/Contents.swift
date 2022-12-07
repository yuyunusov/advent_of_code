import Foundation

struct File {
    let name: String
    let size: Int
}

class Dir {
    let name: String
    var files: [File] = []
    var dirs: [Dir] = []

    var size: Int {
        files.reduce(0) { partialResult, file in
            partialResult + file.size
        } + dirs.reduce(0, { partialResult, dir in
            partialResult + dir.size
        })
    }

    var allDirs: [Dir] {
        dirs + dirs.flatMap { $0.allDirs }
    }

    init(name: String) {
        self.name = name
    }

    func getOrCreateDir(_ name: String) -> Dir {
        if let dir = dirs.first(where: { $0.name == name }) {
            return dir
        } else {
            let dir = Dir(name: name)
            dirs.append(dir)
            return dir
        }
    }

    func getOrCreateFile(_ name: String, size: Int) -> File {
        if let file = files.first(where: { $0.name == name }) {
            return file
        } else {
            let file = File(name: name, size: size)
            files.append(file)
            return file
        }
    }
}

func parseLogs(_ logs: [String]) -> Dir {
    let rootPath = Dir(name: "")
    var dirPath: [Dir] = [rootPath]

    for log in logs {
        var lines = log.split(separator: "\n")
        let command = lines.removeFirst()
        if command.starts(with: "cd ") {
            let path = command.suffix(command.count - 3).split(separator: "/")
            for dirName in path {
                if dirName == ".." {
                    dirPath.removeLast()
                } else {
                    dirPath.append(dirPath[dirPath.count - 1].getOrCreateDir(String(dirName)))
                }
            }
        } else if command.starts(with: "ls") {
            for line in lines {
                if line.starts(with: "dir") {
                    let name = line.split(separator: " ").last ?? ""
                    dirPath[dirPath.count - 1].getOrCreateDir(String(name))
                } else {
                    let args = line.split(separator: " ").map { String($0) }
                    dirPath[dirPath.count - 1].getOrCreateFile(args[1], size: Int(args[0]) ?? 0)
                }
            }
        }
    }
    return rootPath
}

func part1(_ rootDir: Dir) -> Int {
    rootDir.allDirs.reduce(0, { partialResult, dir in
        let size = dir.size
        return size <= 100_000 ? partialResult + size : partialResult
    })
}

func part2(_ rootDir: Dir) -> Int {
    let totalSize = 70_000_000
    let needSpace = 30_000_000

    let needToDeleteSpace = needSpace - (totalSize - rootDir.size)
    return rootDir.allDirs.reduce(totalSize) { minSpace, dir in
        let size = dir.size
        if size > needToDeleteSpace, size < minSpace {
            return size
        } else {
            return minSpace
        }
    }
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let logs = try String(contentsOfFile: path!, encoding: String.Encoding.utf8).split(separator: "$ ").map { String($0 ) }

let rootDir = parseLogs(logs)
print(part1(rootDir))
print(part2(rootDir))
