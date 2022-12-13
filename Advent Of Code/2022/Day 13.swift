//
//  Day 13.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation

extension AOC2022 {
    final class Day13: AOC2022Solver {

        enum MixedValue: CustomStringConvertible, Comparable {
            case int(_ value: Int)
            case array(_ value: [MixedValue], _ isDividerPacket: Bool)

            var description: String {
                switch self {
                case let .int(value):
                    return value.string
                case let .array(array, _):
                    return array.description
                }
            }

            static func < (lhs: MixedValue, rhs: MixedValue) -> Bool {
                switch (lhs, rhs) {
                case (.int(let a), .int(let b)):
                    return a < b
                case (.array(let a, _), .int):
                    guard a.count > 0 else {
                        return true
                    }
                    return rhs == a[0] ? false : a[0] < rhs

                case (.array(let a, _), .array(let b, _)):
                    for i in 0..<min(a.count, b.count) {
                        if a[i] < b[i] {
                            return true
                        } else if a[i] == b[i] {
                            continue
                        } else {
                            return false
                        }
                    }
                    return a.count < b.count
                case (.int, .array(let b, _)):
                    guard b.count > 0 else {
                        return false
                    }

                    return lhs == b[0] ? true : lhs < b[0]
                }
            }

            static func == (lhs: MixedValue, rhs: MixedValue) -> Bool {
                switch (lhs, rhs) {
                case (.int(let a), .int(let b)):
                    return a == b
                case (.array(let a, _), .int):
                    return a.count > 0 ? a[0] == rhs : false
                case (.array(let a, _), .array(let b, _)):
                    for i in 0..<min(a.count, b.count) {
                        if a[i] != b[i] {
                            return false
                        }
                    }
                    return a.count == b.count
                case (.int, .array(let b, _)):
                    return b.count > 0 ? lhs == b[0] : false
                }
            }
        }

        private lazy var pairs = parse()

        private func parse() -> [[MixedValue]] {
            let rawPairs = input.split(separator: "\n\n")

            var result = [[MixedValue]]()
            for rawPair in rawPairs {
                let pair = rawPair.split(separator: "\n")

                result.append([parse(pair[0]), parse(pair[1])])
            }
            return result
        }

        private func parse(_ row: any StringProtocol) -> MixedValue {
            var index = 1
            return parse(row, index: &index)
        }

        private func parse(_ row: any StringProtocol, index: inout Int) -> MixedValue {
            var result = [MixedValue]()
            
            while index < row.count {
                let symbol = row[index]
                index += 1

                switch symbol {
                case "[":
                    result.append(parse(row, index: &index))
                case "]":
                    return .array(result, false)
                case ",", " ":
                    continue
                default:
                    var value = String(symbol)
                    
                    while index < row.count && !",[]".contains(row[index]) {
                        value += String(row[index])
                        index += 1
                    }
                    result.append(.int(value.int ?? 0))
                }
            }
            return .array(result, false)
        }

        func part1() -> String {
            var result = 0
            for (i, pair) in pairs.enumerated() {
                result += pair[0] < pair[1] ? i + 1 : 0
            }

            return result.string
        }

        func part2() -> String {
            var result = 1
            let dividerPackets: [MixedValue] = [
                .array([
                    .array([.int(6)], false)
                ], true),
                .array([
                    .array([.int(2)], false)
                ], true)
            ]
            pairs.append(dividerPackets)

            let packets = pairs.flatMap( { $0 }).sorted(by: <)
            for (i, p) in packets.enumerated() {
                switch p {
                case let .array(_, isDivider):
                    if isDivider {
                        result *= i + 1
                    }
                default:
                    continue
                }
            }

            return result.string
        }
    }
}
