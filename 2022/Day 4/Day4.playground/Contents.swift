import Foundation

struct Range {
    let lValue: Int
    let rValue: Int

    init(raw: String) {
        let rawRange = raw.split(separator: "-")
        lValue = Int(rawRange[0]) ?? -1
        rValue = Int(rawRange[1]) ?? -1
    }

    func includes(_ value: Int) -> Bool {
        lValue <= value && rValue >= value
    }

    func includes(_ range: Range) -> Bool {
        includes(range.lValue) && includes(range.rValue)
    }

    func includesPartially(_ range: Range) -> Bool {
        includes(range.lValue) || includes(range.rValue)
    }
}

func part1(_ pairs: [[Range]]) -> Int {
    pairs.reduce(0) { partialResult, ranges in
        if ranges[0].includes(ranges[1]) || ranges[1].includes(ranges[0]) {
            return partialResult + 1
        } else {
            return partialResult
        }
    }
}

func part2(_ pairs: [[Range]]) -> Int {
    pairs.reduce(0) { partialResult, ranges in
        if ranges[0].includesPartially(ranges[1]) || ranges[1].includesPartially(ranges[0]) {
            return partialResult + 1
        } else {
            return partialResult
        }
    }
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let data = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let pairs = data.split(separator: "\n").map { row in
    row.split(separator: ",").map { Range(raw: String($0)) }
}


print(part1(pairs))
print(part2(pairs))
