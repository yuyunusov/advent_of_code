//
//  input 12.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation

extension AOC2022.Day12 {
    var input: String {
        """
abaaaaacccccccccccccccccccccccccccccccccccccccaaaaaaaccccaaaaaaaaaaaaaaaaacccccaaaaaacccccccccccccccccccccccaaaaaaaaccccccccccccccccccccccccccccccccaaaaaa
abaaaaaacccaaaacccccccccccccccccccccccaccccccccaaaaaaaaccaaaaaaaaaaaaaaaaccccccaaaaaacccccccccccccccccccccccccaaaaccccccccccccccccccccccccccccccccccaaaaaa
abaaaaaacccaaaacccccccccccccccccaaaaaaaacccccccaaaaaaaaacaaaaaaaaaaaaacccccccccaaaaacccccccccccccccccccccccccaaaaacccccccccccccccccccaaaccccccccccccaaaaaa
abaaacaccccaaaaccccccccccccccccccaaaaaacccccccccaaaaaaaccccaaaaaaaaaaacccccccccaaaaacccccccccccccccccccccccccaacaaaccccccccccccccccccaaacccccccccccccccaaa
abaaacccccccaaacccccccccccaacccccaaaaaaccccccccaaaaaaccccccaacaaaaaaaacccccccccccccccccccccccaaccccccccccccccacccaaaaacccccccccaaccccaaacccccccccccccccaaa
abccccccccccccccccccccccccaaaaccaaaaaaaacccccccaaaaaaaccccccccaaaaaaaaaccccccccccaacccccccccaaaccccccccccccccccccacaaacccccccccaaaaccaaacccccccccccccccaac
abccccccccccccccccccccccaaaaaacaaaaaaaaaaccccccaaccaaaaacccccaaaaccaaaaccccccccccaaacaacccccaaacaaacccaaccccccccaaaaaaaacccccccaaaaakkkkkkcccccccccccccccc
abccccccccccccccccccccccaaaaaccaaaaaaaaaacccccccccccaaaaaaccccacccaaaaaccccccccccaaaaaaccaaaaaaaaaaaaaaaccccccccaaaaaaaaccccccccaaajkkkkkkkaccccccaacccccc
abcccccccccccccccccccccccaaaaacacacaaaccccccccccccccaaaaaaccccccccaaaacccccccccaaaaaaacccaaaaaaaaaaaaaaaaaccccccccaaaaaccccccccccjjjkkkkkkkkccaaaaaacccccc
abcccccccccccccccccccccccaacaacccccaaacccaccccccccccaaaaaaccccccccaaaacccccccccaaaaaaacccccaaaaaacaaaaaaaacccccccaaaaacccccccjjjjjjjooopppkkkcaaaaaaaccccc
abcccccccccccccccccaacaacccccccccccaaaaaaacccccccccccaaaaacccccccccccccccccccccccaaaaaaccccaaaaaaccaaaaaaacccccccaaaaaacciijjjjjjjjoooopppkkkcaaaaaaaacccc
abccccccccccaaaccccaaaaacccccccccccccaaaaacccccccccccaaaaccccccccccccccccccccccccaacaaaccccaaaaaaacaaaaacccccccccaccaaaciiiijjjjjjoooopppppkllcaaaaaaacccc
abccaaccccccaaaaacaaaaacccccccccccccaaaaaacccccccccccccccccccccccccccccccccccccccaacccccccaaaacaaaaaaaaacccaaccccaaaaaciiiiinoooooooouuuupplllaaaaaacccccc
abcaaacccccaaaaaacaaaaaacccccccccccaaaaaaaaccccccccaacaccccccccccccccccccccccccccccccccccccaccccccccccaaccaaaccccaaaaaciiinnnooooooouuuuuppplllaaacacccccc
abaaaaaacccaaaaaacccaaaacccccccccccaaaaaaaaccccccccaaaaccccccccccccccccccccccccccccccccccccccccccccccccaaaaacaacaaaaaaiiinnnnntttoouuuuuupppllllcccccccccc
abaaaaaaccccaaaaacccaaccccccccccacccccaaccccccccccaaaaaccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaacaaaaaaiiinnnnttttuuuuxxuuupppllllccccccccc
abaaaaacccccaacaaccccccccccccccaaaccccaacccccaacccaaaaaacccccccccccccccccccccccccccccccccccccccccccccccccaaaaaccaaaaaaiiinnnttttxxuuxxyyuuppppllllcccccccc
abaaaacccccccccccccccccccccaaacaaaccccccaaacaaaaccacaaaacccccccccccccccccccccccccccccccccccaacccccccccccaaaaaccccaaaccciinnntttxxxxxxxyyvvvqqqqqlllccccccc
abaaaaaccccccccccccccccccccaaaaaaaaaacccaaaaaaacccccaaccccccccccccccccccccccccccccccccccccaaacccccccccccaacaaaccccccccciiinntttxxxxxxxyyvvvvvqqqqljjcccccc
abccaaaccaccccccccaaacccccccaaaaaaaaaccccaaaaaacccccccccccccccccccccccccccccccaacccccccaaaaacaaccccccccccccaacccccccccchhinnnttxxxxxxyyyyyvvvvqqqjjjcccccc
SbccccaaaacccccccaaaaaacccccccaaaaaccccccaaaaaaaaccccccccccccccccccccaaccccccaaaaccccccaaaaaaaacccccccccccccccccccccccchhhnnntttxxxxEzyyyyyvvvqqqjjjcccccc
abccccaaaacccccccaaaaaaccccccaaaaaacccccaaaaaaaaaacccccccccccccccccccaaccccccaaaaccccccccaaaaacccccccccccccccccccccccccchhhnntttxxxyyyyyyyvvvvqqqjjjcccccc
abcccaaaaaaccccccaaaaaacccccaaaaaaaccccaaaaaaaaaacccccccccccccccccaaaaaaaacccaaaacccccccaaaaaccccccccccccccccccccccccccchhmmmttxxxyyyyyyvvvvvqqqjjjdcccccc
abcccaaaaaacccccccaaaaacccccaaacaaacaaaaaaaaaaccccccccccccaaacccccaaaaaaaaccccccccccccccaacaaacccccccaacaaacccccccccccchhhmmmtswwwyyyyyyvvvqqqqjjjjdddcccc
abcccccaacccccccccaacaacccccccccccacaaaaaccaaaccccccccccaaaaacccccccaaaacccccccccccccccccccaaccccccccaaaaaacccccccccccchhhmmssswwwwwwyyywvrqqqjjjjdddccccc
abcccccccccccccccccccccccccccccccccaaaaaccccaaccccccccacaaaaaacccccaaaaacccccccccccccccccccccccccccccaaaaaacccccccccccchhhmmssswwwwwwywywwrrqjjjjddddccccc
abcccccccccccccccccccccccccccccccccaaaaaccccccccaaacaaacaaaaaacccccaaaaaaccccccccccccccccccccccccccccaaaaaaaccccccccccchhmmmsssswwsswwwwwwrrkkjjddddcccccc
abccccccccccccccccccccccccccccccccccaaaaacccccccaaaaaaacaaaaaccccccaaccaacccccccccccaaccccccccccccccaaaaaaaacaacaaccccchhhmmmsssssssswwwwrrrkkjddddaaccccc
abcccccccccccccccccccccccccaaaaaccccaacccccccccccaaaaaacaaaaacccccccccccccaacccccccaaaaaacccccccccccaaaaaaaacaaaaaccccchhgmmmmssssssrrwwwrrrkkddddaaaccccc
abcccccccccccccccccccccccccaaaaacccccccccccccccccaaaaaaaacccccccccccccccaaaaaaccccccaaaaaccccaaccccccccaaacccaaaaaaccccgggmmmmmmllllrrrrrrrkkkeedaaaaccccc
abcccccccccccaaccccccccccccaaaaaacccccccccccccccaaaaaaaaacccccccccccccccaaaaaaccccaaaaaaacccaaaacccccccaaccccaaaaaaccccggggmmmmllllllrrrrrkkkkeedaaaaacccc
abcccccccccccaaacaacaaaccccaaaaaaccccccccccccccaaaaaaaaaacccccccccccccccaaaaaaccccaaaaaaaaccaaaacccccccccccccaaaaaccccccgggggglllllllllrrkkkkeeeaaaaaacccc
abcccccccccccaaaaaacaaaacccaaaaaaccccccccccccccaaacaaaaaaccccccccccccccccaaaaaccccaaaaaaaaccaaaacccccccccccaaccaaaccccccgggggggggffflllkkkkkkeeeaaaaaacccc
abaccccccccaaaaaaaccaaaacccccaaacccccccccccccccccccaaaaaacaccccccccaaccccaaaacccccccaaacacccccccccccccccaaaaaccccccccccccccgggggffffflllkkkkeeeccaaacccccc
abaccccccccaaaaaaaccaaacccccccccccccccccaaaccccccccaaacaaaaaccccccaaacccccccccccccaaaacccccccccccccccccccaaaaaccccccccccccccccccaffffffkkkeeeeeccaaccccccc
abaaaccccccccaaaaaaccccccccccccccccccccaaaaaacccccccaaaaaaaacaaaacaaacccccccccaaaaaacccccccccccccccccccccaaaaaccccccccccccccccccccaffffffeeeeecccccccccccc
abaacccccccccaacaaaccccccccccccccccccccaaaaaaccccccccaaaaaccaaaaaaaaacccccccccaaaaaaaaccccccccccaaccccccaaaaacccccccccccccccccccccaaaffffeeeecccccccccccaa
abaacccccccccaaccccccccccccccccaaccccccaaaaacaaccaacccaaaaacaaaaaaaaacccccccccaaaaaaaaccccccaaacaacccccccccaacccccccccccccccccccccaaaccceaecccccccccccccaa
abaacccccccccccccccccccccccccccaaaaaacccaaaaaaaaaaaccaaacaaccaaaaaaaaaaaaacccccaaaaaaacccccccaaaaaccccccccccccccccccccccccccccccccaaacccccccccccccccaaacaa
abcccccccccccccccccccccccccccccaaaaaccccaacaacaaaaacccaaccccccaaaaaaaaaaaacccccaaaaacccccccccaaaaaaaccccccccccccccccccccccccccccccaaacccccccccccccccaaaaaa
abcccccccccccccccccccccccccccaaaaaaaccccccccaaaaaaaaccccccccccaaaaaaaaaaccccccaaaaaaccccccccaaaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccaaaaaa
"""
    }

    var testInput: String {
        """
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
"""
    }
}
