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

struct Position {
    let row: Row
    let col: Column
}

extension Position: Hashable {
    var hashValue: Int {
        return row.hashValue ^ col.hashValue
    }
    static func == (lhs: Position, rhs: Position) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
}

// a type-safe cell! there is no way to make a cell that sits outside the grid or has an invalid symbol
struct Cell {
    let symbol: Symbol
    let position: Position
}

/*:
 - Note:
 We have just encoded a bunch of the rules of tic tac toe simply by writing some enums and structs. This is way better than writing code to check things because the *compiler* keeps us from breaking the rules.
 
 
 - Important:
 Enforcing the other rules can be done in a conceptually similar way. If we only expose legal, acceptable moves as part of our `Game` then noone can ever skip someone else's turn or play on top of an already played `Cell`. In fact, there will be no moves at all when a game is over.
 
 
 - Experiment:
 Your challenge is to populate the `moves` Array with optional closures representing the possible acceptable moves based on the current state of the game.
 */
let positions: [Position] = [Position(row: .top, col: .left), Position(row: .top, col: .middle), Position(row: .top, col: .right),
                             Position(row: .middle, col: .left), Position(row: .middle, col: .middle), Position(row: .middle, col: .right),
                             Position(row: .bottom, col: .left), Position(row: .bottom, col: .middle), Position(row: .bottom, col: .right)]

typealias Move = ()->Game

func movesFor(grid: [Cell], playing: Playable) -> [Position:Move] {
    return [:]
}

struct Game: CustomStringConvertible {
    let grid: [Cell]
    let moves: [Position:Move]
    var description: String { return "\(grid)"} // and this
    
    init(starting: Playable){
        grid = positions.map{ Cell(symbol: .empty, position: $0) }
        moves = movesFor(grid: grid, playing: starting)
    }
    
    init(with newGrid: [Cell], last: Playable) {
        grid = newGrid
        let nextMover = Playable.x // 🐞
        moves = movesFor(grid: grid, playing: nextMover)
    }
}

let initial = Game(starting: .o)

//XCTAssertEqual(9, initial.moves.count, "should have nine possible moves")
//
//let topLeft = Position(row: .top, col: .left)
//XCTAssertNotNil(initial.moves[topLeft], "there should be a move available")
//let first: Game = initial.moves[topLeft]!()
//
//XCTAssertNil(first.moves[topLeft], "we played top, left already so it should be nil")
//
//let second = first.moves[Position(row: .bottom, col: .right)]!()
//let availableMoves = second.moves.count
//
//XCTAssertEqual(7, availableMoves, "there should only be 7 moves left")
//XCTAssert(.played(Playable.x) == second.grid[8].symbol, "second move is by x")
//
//let third = second.moves[Position(row: .top, col: .middle)]!()
//let fourth = third.moves[Position(row: .bottom, col: .middle)]!()
//let fifth = fourth.moves[Position(row: .top, col: .right)]!()
//let noMore = fifth.moves.count
//
//XCTAssertEqual(0, noMore, "this game is over")

/*:
 - Important:
  This set of problems was inspired by a talk, namely [Enterprise Tic-Tac-Toe -- A functional approach with Scott Wlaschin](https://skillsmatter.com/skillscasts/9765-enterprise-tic-tac-toe-a-functional-approach) . It is definately worth a watch.
 
 
 - Note:
 If you feel like you want some more tic tac toe in your life, then try to build a super smart algorithm that no one can defeat.
*/
 
