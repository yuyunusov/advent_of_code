import Foundation

func parseStacks(_ raw: String) -> [[Character]] {
    let rawStacks = raw.split(separator: "\n")
    let numberOfStacks = rawStacks.last?.split(separator: " ").count ?? 0
    let indexes = (0..<numberOfStacks).map { $0 == 0 ? 1 : $0 * 4 + 1 }

    var stacks = [[Character]](repeating: [], count: numberOfStacks)
    for (i, row) in rawStacks.enumerated() {
        guard i != numberOfStacks else {
            continue
        }
        for (j, c) in row.enumerated() {
            if c != " ", let index = indexes.firstIndex(of: j) {
                stacks[index].append(c)
            }
        }
    }
    return stacks
}

func applyInstructions(_ raw: String, stacks: [[Character]], isNewCrane: Bool) -> [[Character]] {
    var result = stacks
    let instructions = raw.split(separator: "\n").map { $0.split(separator: " ")}

    for instruction in instructions {
        let elementIndex = (Int(instruction[1]) ?? -1) - 1
        let fromIndex = (Int(instruction[3]) ?? -1) - 1
        let toIndex = (Int(instruction[5]) ?? -1) - 1

        var elements = result[fromIndex][0..<elementIndex + 1]
        if !isNewCrane {
            elements.reverse()
        }
        result[toIndex].insert(contentsOf: elements, at: 0)
        result[fromIndex].removeFirst(elements.count)
    }

    return result
}

func getAnswer(_ stack: [[Character]]) -> String {
    String(stack.compactMap { $0.first })
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let data = try String(contentsOfFile: path!, encoding: String.Encoding.utf8).split(separator: "\n\n")

let rawStacks = String(data[0])
let rawInstructions = String(data[1])

let stacks = parseStacks(rawStacks)
let part1Stacks = applyInstructions(rawInstructions, stacks: stacks, isNewCrane: false)
let part2Stacks = applyInstructions(rawInstructions, stacks: stacks, isNewCrane: true)
print(getAnswer(part1Stacks))
print(getAnswer(part2Stacks))

