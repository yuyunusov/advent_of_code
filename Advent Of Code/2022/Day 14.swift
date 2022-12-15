//
//  Day 14.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation

extension AOC2022 {
    final class Day14: AOC2022Solver {

        enum State {
            case idle
            case falling
        }

        enum Point: CustomStringConvertible, Equatable {
            case rock
            case sand(_ state: State)
            case air

            var description: String {
                switch self {
                case .air:
                    return "."
                case .rock:
                    return "#"
                case .sand:
                    return "o"
                }
            }
        }

        private func simulate(_ table: Table<Point>) -> Int {
            var point = (x: 500, y: 0)
            table.setValue(point.x, point.y, .sand(.falling))

            while true {
                guard let nextPoint = table.nextPoint(point.x, point.y, direction: .down) else {
                    return table.numberOfEqual(.sand(.idle))
                }
                let value = table.getValue(nextPoint.x, nextPoint.y)
                switch value {
                case .air:
                    table.setValue(nextPoint.x, nextPoint.y, .sand(.falling))
                    table.setValue(point.x, point.y, .air)
                    point = nextPoint
                case .sand(.idle), .rock:


                    if // left down side
                        let nextPointL = table.nextPoint(point.x, point.y, direction: .left),
                        let nextPoint = table.nextPoint(nextPointL.x, nextPointL.y, direction: .down),
                        let nextValue = table.getValue(nextPoint.x, nextPoint.y)
                    {
                        switch nextValue {
                        case .rock, .sand(.idle): // if the left-down value is unreachable

                            if // right down side
                                let nextPointR = table.nextPoint(point.x, point.y, direction: .right),
                                let nextPoint = table.nextPoint(nextPointR.x, nextPointR.y, direction: .down),
                                let nextValue = table.getValue(nextPoint.x, nextPoint.y)
                            {
                                switch nextValue {
                                case .rock, .sand(.idle): // if the right-down value is unreachable
                                    if point.x == 500, point.y == 0 {
                                        table.setValue(point.x, point.y, .sand(.idle))
                                        return table.numberOfEqual(.sand(.idle))
                                    } else {
                                        table.setValue(point.x, point.y, .sand(.idle))
                                        point = (x: 500, y: 0)
                                        table.setValue(point.x, point.y, .sand(.falling))
                                    }
                                default: // if the right-down value is air
                                    table.setValue(nextPoint.x, nextPoint.y, .sand(.falling))
                                    table.setValue(point.x, point.y, .air)
                                    point = nextPoint
                                }
                            } else {
                                table.setValue(point.x, point.y, .sand(.idle))
                                point = (x: 500, y: 0)
                                table.setValue(point.x, point.y, .sand(.falling))
                            }

                        default: // if the left-down value is air
                            table.setValue(nextPoint.x, nextPoint.y, .sand(.falling))
                            table.setValue(point.x, point.y, .air)
                            point = nextPoint
                        }
                    } else { // if two side are unreachable
                        return table.numberOfEqual(.sand(.idle))
                    }
                default:
                    return table.numberOfEqual(.sand(.idle))
                }
            }
        }

        private func parse() -> Table<Point> {
            var columns = 0
            var rows = 0

            let paths = input.components(separatedBy: "\n").map { row in
                row.components(separatedBy: " -> ").map({
                    let point = $0.components(separatedBy: ",").int
                    columns = max(point[0] + 1, columns)
                    rows = max(point[1] + 1, rows)
                    return point
                })
            }

            let table = Table<Point>(defaultValue: .air)
            table.setSize(rows: rows, columns: columns)

            for path in paths {
                var currentPoint = [Int]()
                for point in path {
                    if currentPoint.isEmpty {
                        currentPoint = point
                    } else {
                        table.setValue(currentPoint[0], currentPoint[1], point[0], point[1], .rock)
                        currentPoint = point
                    }
                }
            }
            return table
        }

        func part1() -> String {
            let table = parse()
            return simulate(table).string
        }

        func part2() -> String {
            let table = parse()
            table.setValue(0, table.rows + 1, 1000, table.rows + 1, .rock)
            return simulate(table).string
        }
    }
}
