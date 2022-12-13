//
//  Day 12.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation

extension AOC2022 {
    final class Day12: AOC2022Solver {

        struct HillGraph: Graph {
            struct Vertex: Hashable {
                var x: Int
                var y: Int
                var height: Int = Int.max

                static func == (lhs: Vertex, rhs: Vertex) -> Bool {
                    return lhs.x == rhs.x && lhs.y == rhs.y
                }

                func hash(into hasher: inout Hasher) {
                    hasher.combine(x.hashValue ^ y.hashValue)
                }
            }

            struct Edge: WeightedEdge {
                var cost: Double = 1
                var target: Vertex
            }


            var data: [String]

            func edgesOutgoing(from vertex: Vertex) -> [Edge] {
                let x = vertex.x
                let y = vertex.y
                var edges = [Edge]()
                if y > 0, diff(data[y][x], data[y - 1][x]) >= -1 { // top
                    edges.append(Edge(cost: 1, target: .init(x: x, y: y - 1)))
                }
                if y < data.count - 1, diff(data[y][x], data[y + 1][x]) >= -1 { // down
                    edges.append(Edge(cost: 1, target: .init(x: x, y: y + 1)))
                }
                if x > 0, diff(data[y][x], data[y][x - 1]) >= -1 { // left
                    edges.append(Edge(cost: 1, target: .init(x: x - 1, y: y)))
                }
                if x < data[y].count - 1, diff(data[y][x], data[y][x + 1]) >= -1 { // right
                    edges.append(Edge(cost: 1, target: .init(x: x + 1, y: y)))
                }
                return edges
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

        private lazy var data = input.components(separatedBy: "\n")

        private func solve(startSymbols: [Character]) -> Int {
            let graph = HillGraph(data: data)
            var startVertex: [HillGraph.Vertex] = []
            var endVertex: HillGraph.Vertex?

            for y in 0..<data.count {
                for x in 0..<data[y].count {
                    if startSymbols.contains(data[y][x]) {
                        startVertex.append(.init(x: x, y: y))
                    } else if data[y][x] == "E" {
                        endVertex = .init(x: x, y: y)
                    }
                }
            }
            if let endVertex {
                var minValue = Int.max
                for s in startVertex {
                    let astar = AStar(graph: graph) { v1, v2 in
                        Double(abs(v1.x - v2.x) + abs(v1.y - v2.y))
                    }
                    let path = astar.path(start: s, target: endVertex)
                    if path.isEmpty {
                        continue
                    }
                    minValue = min(path.count - 1, minValue)
                }
                return minValue
            }
            return 0
        }

        func part1() -> String {
            solve(startSymbols: ["S"]).string
        }

        func part2() -> String {
            solve(startSymbols: ["S", "a"]).string
        }
    }
}
