//
//  FifteenModel.swift
//  FifteenPuzzle
//
//  Created by Guy Greenleaf on 2/7/21.
//

import Foundation

struct FifteenModel{
    //Internal representation of the game, including logic for playing.
    
    var gameBoard:[ [BoardCell] ] = []
    var gameRows = 4
    var gameCols = 4
    var getGameCells = 1
    var logicGameCells = 1
    
    //Create a logical game board using a 2-dimensional array
    //The final cell is set to a CellType of freeCell, this is the cell that anchors the users movement to left, right, up, or down provided there is a space to move in that direction
    mutating func createGameFor(rows: Int, columns: Int) {
        for rowIdx in 0..<rows {
            gameBoard.append( [BoardCell]() )
            for _ in 0..<columns {
                //CellType.fiftennCell now holds the number of each square (1-15)
                gameBoard[rowIdx].append(BoardCell(cellType: CellType.fifteenCell(number: logicGameCells), cellNumber: logicGameCells))
                //Increment by 1 each time
                logicGameCells += 1
                
                //Once we make all 15 squares, set the 16th cell to a freeCell.
                if(logicGameCells == 17){
                    gameBoard[3][3].cellType = CellType.freeCell
                }
            }
        }
    }
    

    func gameSize() ->(rows: Int, columns: Int){
        return (gameRows, gameCols)
    }
    
    func getCellType(row: Int, col: Int) ->CellType{
        return gameBoard[row][col].cellType
    }
    
}
enum CellType {
    case fifteenCell(number: Int)
    case freeCell
}

struct BoardCell {
    var cellType: CellType
    var cellNumber: Int
}
