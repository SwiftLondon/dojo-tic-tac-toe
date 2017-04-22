//: [Previous](@previous)

/*:
 # tic tac types!
 
 While we were able to get a game working, enforcing all the rules of tic tac toe was tedious and made for some ungainly code. Lets make the type system work for us instead.
 */

import XCTest

// If we create enums for X and O, then we dont need to worry about anyone playing a "Z" ever again
enum Playable {
    case x
    case o
}

// Each cell in our grid can either be `played` or `empty`, if it was `played` then it is one of the two `Playable` types
enum Symbol {
    case played(Playable)
    case empty
}

/// just here to help
extension Symbol: CustomStringConvertible {
    var description: String {
        switch self {
        case .empty:
            return " "
        case .played(Playable.o):
            return "O"
        case .played(Playable.x):
            return "X"
        }
    }
}

extension Symbol: Equatable {
    static func ==(_ lhs: Symbol, _ rhs: Symbol) -> Bool {
        switch (lhs, rhs) {
        case (.empty, .empty):
            return true
        case (let .played(lplay), let .played(rplay)):
            return lplay == rplay
        default:
            return false
        }
    }
}

// nor do we need to worry about the height ...
enum Row: Int {
    case top, middle, bottom
}

// or width of the grid if we create enums for them all
enum Column: Int {
    case left, middle, right
}

// a type-safe cell! there is no way to make a cell that sits outside the grid or has an invalid symbol
struct Cell {
    let symbol: Symbol
    let row: Row
    let column: Column
}

/*:
 - Note:
 We have just encoded a bunch of the rules of tic tac toe simply by writing some `enum`s and a struct. This is way better than writing code to check things because the *compiler* keeps us from breaking the rules.
 
 
 - Important:
 Enforcing the other rules can be done in a conceptually similar way. If we only expose legal, acceptable moves as part of our `Game` then noone can ever skip someone else's turn or play on top of an already played `Cell`. In fact, there will be no moves at all when a game is over.
 
 
 - Experiment:
 Your challenge is to populate the `moves` Array with optional closures representing the possible acceptable moves based on the current state of the game.
 */
let positions: Array<(Row, Column)> = [(row: .top, col: .left), (row: .top, col: .middle), (row: .top, col: .right),
                                       (row: .middle, col: .left), (row: .middle, col: .middle), (row: .middle, col: .right),
                                       (row: .bottom, col: .left), (row: .bottom, col: .middle), (row: .bottom, col: .right)]

struct Game: CustomStringConvertible {
    typealias Move = ()->Game
    let grid: [Cell]
    let moves: [Move?] // you might want to upgrade this
    var description: String { return "\(grid)"} // and this
    
    init(starting: Playable){
        grid = positions.map{ Cell(symbol: .empty, row: $0.0, column: $0.1) }
        moves = grid.enumerated().map{ (index, _) in
            return { Game(starting: starting) }
        }
    }
}

let initial = Game(starting: .o)

XCTAssertEqual(9, initial.moves.count, "should have nine possible moves")

let first: Game = initial.moves[0]!()

//XCTAssertNil(first.moves[0], "we played 0 already so it should be nil")

let second = first.moves[8]!()
let availableMoves = second.moves.filter({ $0 != nil }).count

//XCTAssertEqual(7, availableMoves, "there should only be 7 moves left")
//XCTAssert(.played(Playable.x) == second.grid[8].symbol, "second move is by x")

let third = second.moves[1]!()
let fourth = third.moves[7]!()
let fifth = fourth.moves[2]!()
let noMore = fifth.moves.filter({ $0 != nil }).count

//XCTAssertEqual(0, noMore, "this game is over")

/*:
 - Important:
  This set of problems was inspired by a talk, namely [Enterprise Tic-Tac-Toe -- A functional approach with Scott Wlaschin](https://skillsmatter.com/skillscasts/9765-enterprise-tic-tac-toe-a-functional-approach) . It is definately worth a watch.
 
 
 - Note:
 If you feel like you want some more tic tac toe in your life, then try to build a super smart algorithm that no one can defeat.
*/
 
