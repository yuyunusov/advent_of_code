//
//  Day 3.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation

extension AOC2022 {
    final class Day3: AOC2022Solver {

        private lazy var rucksacks = input.split(separator: "\n").map { String($0) }

        private func convertAsciiValue(_ value: Int) -> Int {
            if value > 96 {
                return value - 96
            } else if value < 97, value > 64 {
                return value - 38
            } else {
                return 0
            }
        }

        func part1() -> String {
            rucksacks.reduce(0) { partialResult, rucksack in
                let compartment1 = Set(rucksack.prefix(rucksack.count / 2))
                let compartment2 = Set(rucksack.suffix(rucksack.count / 2))

                if let intersection = compartment1.intersection(compartment2).first {
                    return partialResult + convertAsciiValue(Int(intersection.asciiValue ?? 0))
                } else {
                    return partialResult
                }
            }.string
        }
        func part2() -> String {
            var lastGroup = [String]()
            var result = 0
            for rucksack in rucksacks {
                lastGroup.append(rucksack)
                if lastGroup.count == 3 {
                    let sets = lastGroup.map { Set(String($0)) }
                    let symbol = sets.reduce(sets.first ?? Set<String.Element>()) { (result, list)  in
                        result.intersection(list)
                    }.first
                    result += convertAsciiValue(Int(symbol?.asciiValue ?? 0))
                    lastGroup.removeAll()
                }
            }
            return result.string
        }
    }

}
