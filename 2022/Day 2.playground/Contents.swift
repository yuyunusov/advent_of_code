import Foundation

enum Move {
    case rock, paper, scissors

    var point: Int {
        switch self {
        case .rock:
            return 1
        case .paper:
            return 2
        case .scissors:
            return 3
        }
    }

    var loseMove: Move {
        switch self {
        case .paper:
            return .rock
        case .rock:
            return .scissors
        case .scissors:
            return .paper
        }
    }
}

enum Symbol: String {
    case A, B, C, X, Y, Z

    var move: Move {
        switch self {
        case .A, .X:
            return .rock
        case .B, .Y:
            return .paper
        case .C, .Z:
            return .scissors
        }
    }
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let data = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let pairs = data.split(separator: "\n").map { $0.split(separator: " ").map  { Symbol(rawValue: String($0)) ?? .A } }

var part1Points = 0
var part2Points = 0
for pair in pairs {
    let points1 = pair[0].move.point
    let points2 = pair[1].move.point
    part1Points += points2

    if points1 == points2 {
        part1Points += 3
    } else if (pair[1].move == .paper  && pair[0].move == .rock)
        || (pair[1].move == .rock && pair[0].move == .scissors)
        || (pair[1].move == .scissors && pair[0].move == .paper) {
        part1Points += 6
    }

    if pair[1] == .X {
        part2Points += pair[0].move.loseMove.point
    } else if pair[1] == .Y {
        part2Points += 3 + pair[0].move.point
    } else if pair[1] == .Z {
        part2Points += 6 + pair[0].move.loseMove.loseMove.point
    }
}

print(part1Points)
print(part2Points)
