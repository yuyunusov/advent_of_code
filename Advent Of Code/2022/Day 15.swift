//
//  Day 15.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation
import Parsing

extension AOC2022 {
    final class Day15: AOC2022Solver {

        enum Signal: CustomStringConvertible {
            case beacon
            case sensor
            case empty
            case `default`

            var description: String {
                switch self {
                case .beacon:
                    return "B"
                case .sensor:
                    return "S"
                case .empty:
                    return "#"
                case .default:
                    return "."
                }
            }
        }

        struct Point {
            let x: Int
            let y: Int
        }

        private func parse() -> [(sensor: Point, beacon: Point, distance: Int)] {
            let parser = Parse {
                "Sensor at x="
                Int.parser()
                ", y="
                Int.parser()
                ": closest beacon is at x="
                Int.parser()
                ", y="
                Int.parser()
            }
            let lines = input.components(separatedBy: "\n")
            var result = [(sensor: Point, beacon: Point, distance: Int)]()
            for line in lines {
                guard let points = try? parser.parse(line) else {
                    continue
                }
                let distance = abs(points.0 - points.2) + abs(points.1 - points.3)
                result.append((sensor: Point(x: points.0, y: points.1), beacon: Point(x: points.2, y: points.3), distance: distance))
            }
            return result
        }

        func part1() -> String {
            let points = parse()

            var result = Set<Int>()
            let y = 2000000

            for point in points {
                let distance = abs(y - point.sensor.y)
                let tail = point.distance - distance
                if tail > 0 {
                    result.formUnion(point.sensor.x - tail...point.sensor.x + tail)
                }
            }

            for point in points {
                if point.sensor.y == y {
                    result.remove(point.sensor.x)
                }
                if point.beacon.y == y {
                    result.remove(point.beacon.x)
                }
            }
            return result.count.string
        }

        func part2() -> String {
            let points = parse()

            let range = 0...4_000_000

            for y in range {
                var unseen = IndexSet(integersIn: range)
                for point in points {
                    let distance = abs(y - point.sensor.y)
                    let tail = point.distance - distance
                    if tail > 0 {
                        let left = max(point.sensor.x - tail, 0)
                        let right = min(point.sensor.x + tail, range.upperBound)
                        unseen.remove(integersIn: left...right)
                    }
                }
                if !unseen.isEmpty {
                    let x = unseen.first!
                    return ((x * 4_000_000) + y).string
                }
            }
            return ""
        }
    }
}
