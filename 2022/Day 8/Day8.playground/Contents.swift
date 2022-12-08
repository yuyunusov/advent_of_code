import Foundation

struct Point: Hashable {
    let x: Int
    let y: Int
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let data = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

let rows = data.split(separator: "\n").map {$0.split(separator: "").map( { Int(String($0)) ?? -1 } ) }

func part1(_ rows: [[Int]]) -> Int {
    var points = Set<Point>()

    for height in 0..<10 {
        for y in 0..<rows.count {
            var skipLeft = false
            var skipRight = false
            for x in 0..<rows[y].count {
                guard !skipLeft || !skipRight else {
                    break
                }
                let rightX = (rows[y].count - 1) - x
                if !skipLeft {
                    skipLeft = rows[y][x] >= height
                    if rows[y][x] == height {
                        points.insert(Point(x: x, y: y))
                    }
                }
                if !skipRight {
                    skipRight = rows[y][rightX] >= height
                    if rows[y][rightX] == height {
                        points.insert(Point(x: rightX, y: y))
                    }
                }
            }
        }

        for x in 0..<rows[0].count {
            var skipTop = false
            var skipBottom = false
            for y in 0..<rows.count {
                guard !skipTop || !skipBottom else {
                    break
                }
                let bottomY = (rows.count - 1) - y
                if !skipTop {
                    skipTop = rows[y][x] >= height
                    if rows[y][x] == height {
                        points.insert(Point(x: x, y: y))
                    }
                }
                if !skipBottom {
                    skipBottom = rows[bottomY][x] >= height
                    if rows[bottomY][x] == height {
                        points.insert(Point(x: x, y: bottomY))
                    }
                }
            }
        }
    }
    return points.count
}

func part2(_ rows: [[Int]]) -> Int {
    var distances = [Int]()
    for y in 1..<rows.count - 1 {
        for x in 1..<rows[y].count - 1 {

            var counter1 = 0
            for topDirectionY in (0..<y).reversed() {
                counter1 += 1
                if rows[topDirectionY][x] >= rows[y][x] {
                    break
                }
            }

            var counter2 = 0
            for bottomDirectionY in y + 1..<rows.count {
                counter2 += 1
                if rows[bottomDirectionY][x] >= rows[y][x] {
                    break
                }
            }

            var counter3 = 0
            for leftDirectionX in (0..<x).reversed() {
                counter3 += 1
                if rows[y][leftDirectionX] >= rows[y][x] {
                    break
                }
            }

            var counter4 = 0
            for rightDirectionX in x + 1..<rows[y].count {
                counter4 += 1
                if rows[y][rightDirectionX] >= rows[y][x] {
                    break
                }
            }
            distances.append(counter1 * counter2 * counter3 * counter4)
        }
    }

    return distances.reduce(0) { maxDistance, distance in
        maxDistance < distance ? distance : maxDistance
    }
}

print(part1(rows))
print(part2(rows))
