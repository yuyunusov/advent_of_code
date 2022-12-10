import Foundation

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
    private(set) var screen = ""

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

func solve(_ program: [Substring.SubSequence]) {
    var executor = Executor()
    for command in program {
        let command = Command(raw: String(command))
        executor.execute(command)
    }

    print("part 1:", executor.strength)
    print("part 2:")
    print(executor.screen)
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let data = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let program = data.split(separator: "\n")

solve(program)
