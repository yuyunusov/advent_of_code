//
//  main.swift
//  Day 11
//
//  Created by Yunus Yunusov on 11.12.2022.
//

import Foundation

enum Operation {
    case plus(_ value: Int)
    case minus(_ value: Int)
    case multiply(_ value: Int)
    case square

    init(raw: [String]) {
        guard raw.count == 2, raw[1] != "old" else {
            self = .square
            return
        }

        switch raw[0] {
        case "+":
            self = .plus(Int(raw[1]) ?? 0)
        case "-":
            self = .minus(Int(raw[1]) ?? 0)
        case "*":
            self = .multiply(Int(raw[1]) ?? 0)
        default:
            self = .plus(0)
        }
    }

    func calculate(on value: Int) -> Int {
        switch self {
        case let .plus(operand):
            return value + operand
        case let .minus(operand):
            return value - operand
        case let .multiply(operand):
            return value * operand
        case .square:
            return value * value
        }
    }
}

struct Test {
    let nextMonkey1: Int
    let nextMonkey2: Int
    let divideBy: Int

    init(nextMonkey1: Int, nextMonkey2: Int, divideBy: Int) {
        self.nextMonkey1 = nextMonkey1
        self.nextMonkey2 = nextMonkey2
        self.divideBy = divideBy
    }

    func nextMonkey(for value: Int) -> Int {
        value % divideBy == 0 ? nextMonkey1 : nextMonkey2
    }
}

class Monkey {
    var items: [Int]
    var counter = 0
    var operation: Operation
    var test: Test

    init(items: [Int], operation: Operation, test: Test) {
        self.items = items
        self.operation = operation
        self.test = test
    }

    func throwItem(mod: Int? = nil) -> (item: Int, index: Int)? {
        guard !items.isEmpty else {
            return nil
        }
        counter += 1
        let item = items.removeFirst()
        let value: Int = {
            if let mod {
                return operation.calculate(on: item) % mod
            } else {
                return operation.calculate(on: item) % 3
            }
        }()
        return (item: value, index: test.nextMonkey(for: value))
    }

    func catchItem(_ item: Int) {
        items.append(item)
    }
}

func parse(_ raw: String) -> [Monkey] {
    let monkeys = raw.split(separator: "\n\n").map { block in
        let rows = block.split(separator: "\n")
        let items = rows[1].split(separator: ": ").last?.split(separator: ", ").map { Int($0) ?? 0 } ?? []
        let operation = Operation(raw: String(rows[2].split(separator: "new = old ").last ?? "").components(separatedBy: " "))
        let divideBy = Int(rows[3].components(separatedBy: " ").last ?? "") ?? 0
        let monkey1 = Int(rows[4].components(separatedBy: " ").last ?? "") ?? 0
        let monkey2 = Int(rows[5].components(separatedBy: " ").last ?? "") ?? 0
        let test = Test(nextMonkey1: monkey1, nextMonkey2: monkey2, divideBy: divideBy)

        return Monkey(items: items, operation: operation, test: test)
    }

    return monkeys
}

func solve(_ monkeys: [Monkey], rounds: Int, mod: Int?) -> Int {
    let mod = monkeys.map { $0.test.divideBy }.reduce(1, *)

    for _ in 0..<rounds {
        for monkey in monkeys {
            while !monkey.items.isEmpty {
                guard let result = monkey.throwItem(mod: mod) else {
                    continue
                }
                monkeys[result.index].catchItem(result.item)
            }
        }
    }
    return monkeys.map(\.counter).sorted(by: >)[0..<min(monkeys.count, 2)].reduce(1, *)
}

func part1() {
    let monkeys = parse(input)
    print("part 1:", solve(monkeys, rounds: 20, mod: nil))
}

func part2() {
    let monkeys = parse(input)
    let mod = monkeys.map { $0.test.divideBy }.reduce(1, *)
    print("part 2:", solve(monkeys, rounds: 10000, mod: mod))
}

part1()
part2()
