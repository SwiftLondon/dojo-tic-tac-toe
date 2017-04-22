//: [Previous](@previous)
/*:
 # Now lets play!
 
 Nice work getting that test to pass!
 If you like, you can copy over your `display` func and use it in the `description` var within the `Game` struct below.
 
 However, the main thing we need is a `move` function,
 something that transforms a game as per a player's wishes. 
 A game might look a bit like this
 
 ````
 let first = move("O", to: 4, in: Game(starting: "O")
 let second = move("X", to: 0, in: first)
 let third = move("O", to: 6, in: second)
 ````
 
 - Experiment: 
 Write a `move` func that takes the symbol to play, where on the board to play it, and then a `Game` struct. The output of this func is a new, updated `Game`. \
We made a few tests for you but this time they are // mostly commented out
 */
import XCTest

struct Game: CustomStringConvertible {
    
    let goesFirst: String
    let grid: [String]
    var description: String { return " \(grid)" }
    
    init(starting: String) {
        goesFirst = starting
        grid = Array(repeating: " ", count: 9)
    }
}

// implement me!
func move(_ symbol: String, to coord: Int, in game: Game?) -> Game? {
    
    return game
}

let first = move("O", to: 4, in: Game(starting: "O"))
let second = move("X", to: 0, in: first)
let third = move("O", to: 6, in: second)

//XCTAssertEqual([" ", " ", " ", " ", "O", " ", " ", " ", " "],
//               first!.grid,
//               "first move is an O to the center")
//XCTAssertEqual(["X", " ", " ", " ", "O", " ", " ", " ", " "],
//               second!.grid,
//               "second move is an X in first cell")
//XCTAssertEqual(["X", " ", " ", " ", "O", " ", "O", " ", " "],
//               third!.grid,
//               "third move is an O to the bottom left")
/*:
 Alright, now we just have to assert the rules of tic tac toe
 1. cannot play anything but an X or O
 2. cannot play on anything but a 3 x 3 grid
 3. cannot skip turns
 4. cannot change an already played cell
 5. cannot play on a grid that has been won
 
 * Important: 
 Invalid moves should return `nil`
 */
//
//XCTAssertNil(move("Z", to: 8, in: third),
//             "Z is a cool letter but not for tic tac toe")
//
//XCTAssertNil(move("X", to: 12, in: third),
//             "you cannot win like this")
//
//XCTAssertNil(move("O", to: 2, in: third),
//             "hey, its my turn!")
//
//XCTAssertNil(move("X", to: 6, in: third),
//             "you cant change my piece!")
//
//let fourth = move("X", to: 1, in: third)
//let O_is_👑 = move("O", to: 2, in: fourth)
//
//XCTAssertNil(move("X", to: 3, in: O_is_👑), "game still over")
//: if you finish this part, then go help someone else
