import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let calories = try String(contentsOfFile: path!, encoding: String.Encoding.utf8).split(separator: "\n\n").map { $0.split(separator: "\n").map { Int($0) ?? 0 } }

// Part 1
let maxCalories = calories.map { $0.reduce(0, +) }.max() ?? 0
print(maxCalories)

// Part 2
let sumOfTopThree = calories.map { $0.reduce(0, +) }.sorted(by: >)[0..<min(calories.count, 3)].reduce(0, +)
print(sumOfTopThree)
