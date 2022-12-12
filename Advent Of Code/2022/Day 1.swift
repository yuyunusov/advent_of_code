//
//  Day 1.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation

extension AOC2022 {
    final class Day1: AOC2022Solver {
        private lazy var calories: [[Int]] = {
            input.split(separator: "\n\n").map { $0.split(separator: "\n").map { Int($0) ?? 0 } }
        }()

        func part1() -> String {
            (calories.map { $0.reduce(0, +) }.max() ?? 0).string
        }
        
        func part2() -> String {
            calories.map { $0.reduce(0, +) }.sorted(by: >)[0..<min(calories.count, 3)].reduce(0, +).string
        }
    }
}
