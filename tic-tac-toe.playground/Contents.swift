/*:
 # Tic-Tac-Toe FTW!
 
 */

import XCTest


func chunk(list: [String], size: Int) -> [[String]] {
    if (list.count <= size) {
        return [list]
    } else {
        return [Array(list.dropLast(list.count - size))] + chunk(list: Array(list.dropFirst(size)), size: size)
    }
}

//

let microGrid = ["X","X"]

XCTAssertEqual(1, chunk(list: microGrid, size: 2).count, "can chunk smaller lists")
XCTAssertEqual(microGrid, chunk(list: microGrid, size: 2).first!, "identity for first element")

let miniGrid = ["X","X","O",""]
let chunkedMiniGrid = chunk(list: miniGrid, size: 2)
XCTAssertEqual(microGrid, chunkedMiniGrid.first!, "micro for first element of mini")
XCTAssertEqual(["O",""], chunkedMiniGrid[1], "second element equal too?")

let grid = ["X", "X", "O", "X", "O", "O", "O", " ", " "]
let chunkedGrid = chunk(list: grid, size: 3)
XCTAssertEqual(3, chunkedGrid.count, "should be three chunks")

//

func format(grid: [String]) -> String {

    let chunked = chunk(list: grid, size: 3)
        .map { $0.joined(separator: " | ") }
        .map { " \($0)\n" }
        .joined()
    
    return chunked
}

let expectedFormattedGrid = " X | X | O\n X | O | O\n O |   |  \n"
let formattedGrid = format(grid: grid)

print(expectedFormattedGrid)
print(formattedGrid)

XCTAssertEqual(expectedFormattedGrid.characters.count,
               formattedGrid.characters.count,
               "result is same length")
XCTAssertEqual(expectedFormattedGrid, formattedGrid, "should format a nice tic tac toe grid")
