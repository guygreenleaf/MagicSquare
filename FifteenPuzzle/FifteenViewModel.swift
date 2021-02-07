//
//  FifteenViewModel.swift
//  FifteenPuzzle
//
//  Created by Guy Greenleaf on 2/7/21.
//

import Foundation

class FifteenViewModel{
    
    enum bigPiper {
        case isInt(Int)
        case isGreater(String)
    }
    //Bridge between model and view
    
    
    var gameModel = FifteenModel()
    
    init(){
        gameModel.createGameFor()
    }
    
    func gameSize() -> (rows: Int, columns: Int){
    return gameModel.gameSize()
    }
    
    func getGamePiece() -> Int{
        return gameModel.getGameCells
    }

    func gamePiece() -> Int{
        gameModel.getGameCells  += 1
        if(gameModel.getGameCells < 16){
            return gameModel.getGameCells
        }
        return 16
    }
}
