import UIKit

func convertAsciiValue(_ value: Int) -> Int {
    if value > 96 {
        return value - 96
    } else if value < 97, value > 64 {
        return value - 38
    } else {
        return 0
    }
}

func part1(rucksacks: [String]) -> Int {
    rucksacks.reduce(0) { partialResult, rucksack in
        let compartment1 = Set(rucksack.prefix(rucksack.count / 2))
        let compartment2 = Set(rucksack.suffix(rucksack.count / 2))

        if let intersection = compartment1.intersection(compartment2).first {
            return partialResult + convertAsciiValue(Int(intersection.asciiValue ?? 0))
        } else {
            return partialResult
        }
    }
}

func part2(rucksacks: [String]) -> Int {
    var lastGroup = [String]()
    var result = 0
    for rucksack in rucksacks {
        lastGroup.append(rucksack)
        if lastGroup.count == 3 {
            let sets = lastGroup.map { Set(String($0)) }
            let symbol = sets.reduce(sets.first ?? Set<String.Element>()) { (result, list)  in
                result.intersection(list)
            }.first
            result += convertAsciiValue(Int(symbol?.asciiValue ?? 0))
            lastGroup.removeAll()
        }
    }
    return result
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let data = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let rucksacks = data.split(separator: "\n").map { String($0) }



print(part1(rucksacks: rucksacks))
print(part2(rucksacks: rucksacks))


