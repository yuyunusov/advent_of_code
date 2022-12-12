//
//  Day 7.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation

extension AOC2022 {
    final class Day7: AOC2022Solver {
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

            @discardableResult
            func getOrCreateDir(_ name: String) -> Dir {
                if let dir = dirs.first(where: { $0.name == name }) {
                    return dir
                } else {
                    let dir = Dir(name: name)
                    dirs.append(dir)
                    return dir
                }
            }

            @discardableResult
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

        private lazy var logs = input.components(separatedBy: "$ ")
        private lazy var rootDir = parseLogs()

        func parseLogs() -> Dir {
            let rootPath = Dir(name: "")
            var dirPath: [Dir] = [rootPath]

            for log in logs {
                var lines = log.split(separator: "\n")
                guard !lines.isEmpty else {
                    continue
                }
                
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

        func part1() -> String {
            rootDir.allDirs.reduce(0, { partialResult, dir in
                let size = dir.size
                return size <= 100_000 ? partialResult + size : partialResult
            }).string
        }

        func part2() -> String {
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
            }.string
        }
    }
}
