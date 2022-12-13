//
//  Character.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 13.12.2022.
//

import Foundation

extension Character {
    var int: Int? {
        let int = Int(asciiValue ?? 0) - 48
        return int >= 0 && int <= 9 ? int : nil
    }
}
