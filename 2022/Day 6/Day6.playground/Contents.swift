import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")
let data = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

func solve(stream: String, messageLength: Int) -> Int {
    for i in 0..<stream.count {
        let slice = stream.prefix(i).suffix(messageLength)
        if Set(slice).count == slice.count, slice.count == messageLength {
            return i
        }
    }
    return 0
}

print(solve(stream: data, messageLength: 4)) // part 1
print(solve(stream: data, messageLength: 14)) // part 2
