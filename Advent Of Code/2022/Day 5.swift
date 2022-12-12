//
//  Day 5.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation

extension AOC2022 {
    final class Day5: AOC2022Solver {

        private lazy var data = input.split(separator: "\n\n")
        private lazy var stacks = parseStacks()

        private func run(isNewCrane: Bool) -> [[Character]] {
            var result = stacks
            let instructions = data[1].split(separator: "\n").map { $0.split(separator: " ")}

            for instruction in instructions {
                let elementIndex = (Int(instruction[1]) ?? -1) - 1
                let fromIndex = (Int(instruction[3]) ?? -1) - 1
                let toIndex = (Int(instruction[5]) ?? -1) - 1

                var elements = result[fromIndex][0..<elementIndex + 1]
                if !isNewCrane {
                    elements.reverse()
                }
                result[toIndex].insert(contentsOf: elements, at: 0)
                result[fromIndex].removeFirst(elements.count)
            }

            return result
        }

        private func parseStacks() -> [[Character]] {
            let rawStacks = data[0].split(separator: "\n")
            let numberOfStacks = rawStacks.last?.split(separator: " ").count ?? 0
            let indexes = (0..<numberOfStacks).map { $0 == 0 ? 1 : $0 * 4 + 1 }

            var stacks = [[Character]](repeating: [], count: numberOfStacks)
            for (i, row) in rawStacks.enumerated() {
                guard i != numberOfStacks else {
                    continue
                }
                for (j, c) in row.enumerated() {
                    if c != " ", let index = indexes.firstIndex(of: j) {
                        stacks[index].append(c)
                    }
                }
            }
            return stacks
        }

        func solve(_ stack: [[Character]]) -> String {
            String(stack.compactMap { $0.first })
        }

        func part1() -> String {
            solve(run(isNewCrane: false))
        }

        func part2() -> String {
            solve(run(isNewCrane: true))
        }
    }
}
