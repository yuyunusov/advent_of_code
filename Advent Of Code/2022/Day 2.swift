//
//  Day 2.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation

extension AOC2022 {
    final class Day2: AOC2022Solver {
        typealias Result = (part1: Int, part2: Int)

        enum Move {
            case rock, paper, scissors

            var point: Int {
                switch self {
                case .rock:
                    return 1
                case .paper:
                    return 2
                case .scissors:
                    return 3
                }
            }

            var loseMove: Move {
                switch self {
                case .paper:
                    return .rock
                case .rock:
                    return .scissors
                case .scissors:
                    return .paper
                }
            }
        }

        enum Symbol: String {
            case A, B, C, X, Y, Z

            var move: Move {
                switch self {
                case .A, .X:
                    return .rock
                case .B, .Y:
                    return .paper
                case .C, .Z:
                    return .scissors
                }
            }
        }

        private lazy var pairs: [[Symbol]] = input.split(separator: "\n").map { $0.split(separator: " ").map  { Symbol(rawValue: String($0)) ?? .A } }

        private lazy var result: Result = {
            var part1Points = 0
            var part2Points = 0
            for pair in pairs {
                let points1 = pair[0].move.point
                let points2 = pair[1].move.point
                part1Points += points2

                if points1 == points2 {
                    part1Points += 3
                } else if (pair[0].move == pair[1].move.loseMove) {
                    part1Points += 6
                }

                if pair[1] == .X {
                    part2Points += pair[0].move.loseMove.point
                } else if pair[1] == .Y {
                    part2Points += 3 + pair[0].move.point
                } else if pair[1] == .Z {
                    part2Points += 6 + pair[0].move.loseMove.loseMove.point
                }
            }
            return (part1: part1Points, part2: part2Points)
        }()

        func part1() -> String {
            result.part1.string
        }

        func part2() -> String {
            result.part2.string
        }
    }
}
