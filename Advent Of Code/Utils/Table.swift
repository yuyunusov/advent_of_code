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
    private var data: [[T]] = []
    private(set) var columns = 0
    private(set) var rows = 0

    init(defaultValue: T) {
        self.defaultValue = defaultValue
    }

    private func setRows(_ rows: Int) {
        if self.rows < rows {
            for y in 0..<data.count {
                data[y].append(contentsOf: [T](repeating: defaultValue, count: rows - data[y].count))
            }
        } else if self.rows > rows {
            for y in 0..<data.count {
                data[y].removeSubrange(rows - 1..<data[y].count)
            }
        }
        self.rows = rows
    }

    private func setColumns(_ columns: Int) {
        if self.columns < columns {
            data.append(contentsOf: [[T]](repeating: [T](repeating: defaultValue, count: self.rows), count: columns - self.columns))
        } else if self.columns > columns {
            data.removeSubrange(columns - 1..<self.columns)
        }
        self.columns = columns
    }

    func setSize(rows: Int, columns: Int) {
        setColumns(columns)
        setRows(rows)
    }

    func setValue(_ x: Int, _ y: Int, _ value: T) {
        if x >= columns {
            setColumns(x + 1)
        }
        if y >= rows {
            setRows(y + 1)
        }
        data[x][y] = value
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
        guard x < columns, y < rows else {
            return nil
        }
        return data[x][y]
    }

    func nextPoint(_ x: Int, _ y: Int, direction: Direction) -> (x: Int, y: Int)? {
        let nextX = direction.nextX(x)
        let nextY = direction.nextY(y)
        guard nextX >= 0, nextX < columns, nextY >= 0, nextY < rows else {
            return nil
        }
        return (x: nextX, y: nextY)
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
        for y in 0..<rows {
            for x in 0..<columns {
                if data[x][y] == value {
                    counter += 1
                }
            }
        }
        return counter
    }

    func printTable() {
        var result = ""
        for y in 0..<rows {
            var rows = ""
            for x in 430..<min(510, columns) {
                rows += data[x][y].description
            }
            result.append(rows+"\n")
        }
        print(result)
    }
}
