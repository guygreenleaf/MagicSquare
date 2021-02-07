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
    var gameCells:[Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    var getGameCells = 0
    
    mutating func createGameFor() {
        
    }
    

    func gameSize() ->(rows: Int, columns: Int){
        return (gameRows, gameCols)
    }
    
//    func gameCellGet(piece: Int) -> (Int){
//        return gameCells[piece]
//    }
    
    struct BoardCell {
        var cellNumber: Int
        var isFreeCell = false
    }
}
