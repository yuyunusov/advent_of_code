//
//  Array.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 15.12.2022.
//

import Foundation

extension Array where Element == String {
    var int: [Int] {
        self.map { Int($0) ?? 0 }
    }
}
