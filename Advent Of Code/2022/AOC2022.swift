//
//  core.swift
//  Advent Of Code
//
//  Created by Yunus Yunusov on 12.12.2022.
//

import Foundation

protocol AOC2022Solver {
    func part1() -> String
    func part2() -> String
}

final class AOC2022 {

    func solve(_ day: Int) {
        let solver = makeSolver(for: day)
        print("part 1:", solver.part1())
        print("part 2:", solver.part2())
    }
    
    private func makeSolver(for day: Int) -> AOC2022Solver {
        switch day {
        case 1:
            return Day1()
        case 2:
            return Day2()
        case 3:
            return Day3()
        case 4:
            return Day4()
        case 5:
            return Day5()
        case 6:
            return Day6()
        case 7:
            return Day7()
        case 8:
            return Day8()
        case 9:
            return Day9()
        case 10:
            return Day10()
        case 11:
            return Day11()
        case 12:
            return Day12()
        case 13:
            return Day13()
        case 14:
            return Day14()
        case 15:
            return Day15()
        case 16:
            return Day16()
        case 17:
            return Day17()
        case 18:
            return Day18()
        case 19:
            return Day19()
        case 20:
            return Day20()
        case 21:
            return Day21()
        case 22:
            return Day22()
        case 23:
            return Day23()
        case 24:
            return Day24()
        case 25:
            return Day25()
        default:
            return Day1()
        }
    }
}
