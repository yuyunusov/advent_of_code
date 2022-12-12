//
//  Day 6.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation

extension AOC2022 {
    final class Day6: AOC2022Solver {
        private func solve(messageLength: Int) -> Int {
            for i in 0..<input.count {
                let slice = input.prefix(i).suffix(messageLength)
                if Set(slice).count == slice.count, slice.count == messageLength {
                    return i
                }
            }
            return 0
        }

        func part1() -> String {
            solve(messageLength: 4).string
        }

        func part2() -> String {
            solve(messageLength: 14).string
        }
    }
}
