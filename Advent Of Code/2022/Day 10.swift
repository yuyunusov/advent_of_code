//
//  Day 10.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation

extension AOC2022 {
    final class Day10: AOC2022Solver {
        enum Command {
            case noop
            case addx(_ value: Int)

            init(raw: String) {
                if raw == "noop" {
                    self = .noop
                } else {
                    let value = Int(raw.split(separator: " ")[1]) ?? 0
                    self = .addx(value)
                }
            }
        }

        struct Executor {
            private(set) var value = 1
            private(set) var strength = 0
            private(set) var cycles = 0
            private(set) var nextCycle = 20
            private(set) var screen = "\n"

            mutating func execute(_ command: Command) {
                switch command {
                case .noop:
                    inc()
                case let .addx(value):
                    inc()
                    inc()
                    self.value += value
                }
            }

            mutating func inc() {
                cycles += 1
                if cycles == nextCycle {
                    strength += cycles * value
                    nextCycle += 40
                }

                let pixel = cycles % 40
                if pixel >= value, pixel <= value + 2 {
                    screen += "#"
                } else {
                    screen += "."
                }
                if pixel == 0 {
                    screen += "\n"
                }
            }
        }

        private lazy var executor: Executor = {
            var executor = Executor()
            for command in input.split(separator: "\n") {
                let command = Command(raw: String(command))
                executor.execute(command)
            }
            return executor
        }()

        func part1() -> String {
            executor.strength.string
        }

        func part2() -> String {
            executor.screen
        }
    }
}
