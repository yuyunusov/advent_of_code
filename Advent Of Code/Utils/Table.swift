//
//  Table.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 15.12.2022.
//

import Foundation

final class Table<T> where T: CustomStringConvertible & Equatable {
    enum Direction {
        case up, down, left, right

        func nextX(_ x: Int) -> Int {
            switch self {
            case .up, .down:
                return x
            case .left:
                return x - 1
            case .right:
                return x + 1
            }
        }

        func nextY(_ y: Int) -> Int {
            switch self {
            case .right, .left:
                return y
            case .up:
                return y - 1
            case .down:
                return y + 1
            }
        }
    }

    private let defaultValue: T
    private var data = [Int: [Int: T]]()
    private(set) var leftBorder = 0
    private(set) var rightBorder = 0
    private(set) var topBorder = 0
    private(set) var bottomBorder = 0


    init(defaultValue: T) {
        self.defaultValue = defaultValue
    }

    func setValue(_ x: Int, _ y: Int, _ value: T) {
        leftBorder = min(x, leftBorder)
        rightBorder = max(x, rightBorder)
        topBorder = min(y, topBorder)
        bottomBorder = max(y, bottomBorder)

        data[x, default: [:]][y, default: defaultValue] = value
    }

    func setValue(_ x1: Int, _ y1: Int, _ x2: Int, _ y2: Int, _ value: T) {
        guard (x1 - x2 == 0 || y1 - y2 == 0) else {
            return
        }

        for x in min(x1, x2)...max(x1, x2) {
            for y in min(y1, y2)...max(y1, y2) {
                setValue(x, y, value)
            }
        }
    }

    func getValue(_ x: Int, _ y: Int) -> T? {
        data[x]?[y] ?? defaultValue
    }

    func nextPoint(_ x: Int, _ y: Int, direction: Direction) -> (x: Int, y: Int)? {
        let nextX = direction.nextX(x)
        let nextY = direction.nextY(y)

        guard nextX >= leftBorder, nextX <= rightBorder, nextY >= topBorder, nextY <= bottomBorder else {
            return nil
        }
        return (x: nextX, y: nextY )
    }

    func nextPoint(_ x: Int, _ y: Int, directions: [Direction]) -> (x: Int, y: Int)? {
        var result: (x: Int, y: Int)? = (x: x, y: y)
        for direction in directions {
            guard let x = result?.x, let y = result?.y else {
                return nil
            }
            result = nextPoint(x, y, direction: direction)
        }
        return result
    }

    func numberOfEqual(_ value: T) -> Int {
        var counter = 0

        for (_, column) in data {
            for (_, v) in column {
                if v == value {
                    counter += 1
                }
            }
        }
        return counter
    }

    func getRow(_ y: Int) -> [T] {
        var row = [T]()
        for x in leftBorder...rightBorder {
            row.append(data[x]?[y] ?? defaultValue)
        }
        return row
    }

    func printTable() {
        var result = ""
        for y in topBorder...bottomBorder {
            var rows = String(y) + " "
            for x in leftBorder...rightBorder {
                rows += (data[x]?[y] ?? defaultValue).description
            }
            result.append(rows + "\n")
        }
        print(result)
    }
}
