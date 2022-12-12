//
//  Day 4.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation

extension AOC2022 {
    final class Day4: AOC2022Solver {
        struct Range {
            let lValue: Int
            let rValue: Int

            init(raw: String) {
                let rawRange = raw.split(separator: "-")
                lValue = Int(rawRange[0]) ?? -1
                rValue = Int(rawRange[1]) ?? -1
            }

            func includes(_ value: Int) -> Bool {
                lValue <= value && rValue >= value
            }

            func includes(_ range: Range) -> Bool {
                includes(range.lValue) && includes(range.rValue)
            }

            func includesPartially(_ range: Range) -> Bool {
                includes(range.lValue) || includes(range.rValue)
            }
        }

        private lazy var pairs = input.split(separator: "\n").map { row in
            row.split(separator: ",").map { Range(raw: String($0)) }
        }

        func part1() -> String {
            pairs.reduce(0) { partialResult, ranges in
                if ranges[0].includes(ranges[1]) || ranges[1].includes(ranges[0]) {
                    return partialResult + 1
                } else {
                    return partialResult
                }
            }.string
        }

        func part2() -> String {
            pairs.reduce(0) { partialResult, ranges in
                if ranges[0].includesPartially(ranges[1]) || ranges[1].includesPartially(ranges[0]) {
                    return partialResult + 1
                } else {
                    return partialResult
                }
            }.string
        }
    }
}
