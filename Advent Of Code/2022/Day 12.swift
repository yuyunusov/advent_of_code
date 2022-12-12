//
//  Day 12.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation

extension AOC2022 {
    final class Day12: AOC2022Solver {

        struct Point: Hashable {
            let x: Int
            let y: Int
        }

        private var vertices = Set<Vertex>()
        private lazy var data = input.components(separatedBy: "\n")

        private func getVertex(_ y: Int, _ x: Int, _ label: Character) -> Vertex {
            let id = "\(y)_\(x)_\(label)"
            if let vertex = vertices.first (where: { $0.identifier == id }) {
                return vertex
            } else {
                let vertex = Vertex(identifier: id)
                vertices.insert(vertex)
                return vertex
            }
        }

        private func solve(startSymbols: [Character]) -> Int {
            var startVertices = [Vertex]()
            var endVertex: Vertex?

            for y in 0..<data.count {
                for x in 0..<data[y].count {
                    let vertex = getVertex(y, x, data[y][x])

                    if startSymbols.contains(data[y][x]) {
                        startVertices.append(vertex)
                    } else if data[y][x] == "E" {
                        endVertex = vertex
                    }

                    if y > 0, diff(data[y][x], data[y - 1][x]) <= 1 { // top
                        let neighborVertex = getVertex(y - 1, x, data[y - 1][x])
                        neighborVertex.neighbors.append((vertex, 1))
                    }

                    if y < data.count - 1, diff(data[y][x], data[y + 1][x]) <= 1 { // down
                        let neighborVertex = getVertex(y + 1, x, data[y + 1][x])
                        neighborVertex.neighbors.append((vertex, 1))
                    }

                    if x > 0, diff(data[y][x], data[y][x - 1]) <= 1 { // left
                        let neighborVertex = getVertex(y, x - 1, data[y][x - 1])
                        neighborVertex.neighbors.append((vertex, 1))
                    }

                    if x < data[y].count - 1, diff(data[y][x], data[y][x + 1]) <= 1 { // right
                        let neighborVertex = getVertex(y, x + 1, data[y][x + 1])
                        neighborVertex.neighbors.append((vertex, 1))
                    }
                }
            }

            if let endVertex {
                let d = Dijkstra(vertices: vertices)
                var minPath = Int.max
                for startVertex in startVertices {
                    d.findShortestPaths(from: startVertex)
                    if endVertex.pathVerticesFromStart.isEmpty {
                        continue
                    }
                    minPath = min(minPath, Int(endVertex.pathLengthFromStart))
                }

                return minPath
            } else {
                return 0
            }
        }

        func part1() -> String {
            solve(startSymbols: ["S"]).string
        }

        func part2() -> String {
            solve(startSymbols: ["S", "a"]).string
        }


        func diff(_ _a: Character, _ _b: Character) -> Int {
            let a = modifyCharacter(_a)
            let b = modifyCharacter(_b)
            return Int(a.asciiValue ?? 0) - Int(b.asciiValue ?? 0)
        }

        func modifyCharacter(_ c: Character) -> Character {
            if c == "S" {
                return "a"
            } else if c == "E" {
                return "z"
            } else {
                return c
            }
        }
    }
}
