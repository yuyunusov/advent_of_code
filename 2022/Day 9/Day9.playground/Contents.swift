import Foundation

enum Direction {
    case right
    case left
    case up
    case down

    init(_ raw: String) {
        switch raw {
        case "R":
            self = .right
        case "L":
            self = .left
        case "U":
            self = .up
        case "D":
            self = .down
        default:
            self = .right
        }
    }
}

struct Rope {
    var head: Point
    var tail: [Point]
    var direction: Direction
    var steps: Int = 0

    mutating func nextStep() {
        guard steps > 0 else {
            return
        }

        headNextStep()
        tailNextStep()
        steps -= 0
    }

    mutating private func headNextStep() {
        switch direction {
        case .right:
            head.x += 1
        case .left:
            head.x -= 1
        case .up:
            head.y += 1
        case .down:
            head.y -= 1
        }
    }

    mutating private func tailNextStep() {
        var headPoint = head
        for i in 0..<tail.count {
            defer {
                headPoint = tail[i]
            }

            let diffX = headPoint.x - tail[i].x
            let diffY = headPoint.y - tail[i].y

            guard abs(diffX) > 1 || abs(diffY) > 1 else {
                continue
            }

            if abs(diffX) > 0 {
                tail[i].x += 1 * (diffX > 0 ? 1 : -1)
            }
            if abs(diffY) > 0 {
                tail[i].y += 1 * (diffY > 0 ? 1 : -1)
            }
        }
    }
}

struct Point: Hashable {
    var x: Int
    var y: Int
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let data = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let rows = data.split(separator: "\n")

func part1(_ rows: [Substring.SubSequence]) -> Int {
    var positions = Set<Point>()
    var rope = Rope(
        head: Point(x: 0, y: 0),
        tail: [Point](repeating: Point(x: 0, y: 0), count: 9),
        direction: .right
    )

    for row in rows {
        let splitedRow = row.split(separator: " ")
        rope.direction = Direction(String(splitedRow[0]))
        rope.steps = Int(splitedRow[1]) ?? 0
        for _ in 0..<rope.steps {
            rope.nextStep()
            positions.insert(rope.tail[0])
        }
    }
    return positions.count
}

func part2(_ rows: [Substring.SubSequence]) -> Int {
    var positions = Set<Point>()
    var rope = Rope(
        head: Point(x: 0, y: 0),
        tail: [Point](repeating: Point(x: 0, y: 0), count: 9),
        direction: .right
    )

    for row in rows {
        let splitedRow = row.split(separator: " ")
        rope.direction = Direction(String(splitedRow[0]))
        rope.steps = Int(splitedRow[1]) ?? 0
        for _ in 0..<rope.steps {
            rope.nextStep()
            positions.insert(rope.tail[8])
        }
    }
    return positions.count
}

print(part1(rows))
print(part2(rows))
