//
//  FifteenViewModel.swift
//  FifteenPuzzle
//
//  Created by Guy Greenleaf on 2/7/21.
//

import Foundation

class FifteenViewModel: ObservableObject{
    

    //Bridge between model and view
    
    
    @Published var gameModel = FifteenModel()
    
    init(){
        gameModel.createGameFor( rows: 4, columns: 4 )
    }
    
    func gameSize() -> (rows: Int, columns: Int){
    return gameModel.gameSize()
    }
    
    func getGamePiece() -> Int{
        return gameModel.getGameCells
    }
    
    func didTapCell(row: Int, col: Int) {
        print("View: Tapped a \(gameModel.getCellType(row: row, col: col))")
        
    }
    
    func getCell(row: Int, col: Int) -> BoardCell{
        return gameModel.gameBoard[row][col]
    }
    
    func getCellNum(row:Int, col:Int)->Int{
        return gameModel.gameBoard[row][col].cellNumber
    }
    
    func findFreeCell()->(Int, Int){
        for rows in 0...3 {
            for cols in 0...3 {
                let checkCell = gameModel.gameBoard[rows][cols].cellType
                
                if case .freeCell = checkCell {
                    return (rows, cols)
                }
            }
        }
    return (0, 0)
    }
    
    func randSpace(row:Int, col:Int){
        let randInt:Int = Int.random(in: 1...4)
        
        if(randInt == 1 && row != 0){
            let checkUpCell = gameModel.gameBoard[row-1][col].cellType
            if case .fifteenCell = checkUpCell{
                let currentFreeCell = gameModel.gameBoard[row][col]
                let cellToSwap = gameModel.gameBoard[row-1][col]
                gameModel.gameBoard[row][col] = cellToSwap
                gameModel.gameBoard[row-1][col] = currentFreeCell
            }
        }
        else if(randInt == 2 && row != 3){
            let checkBottomCell = gameModel.gameBoard[row+1][col].cellType
            if case .fifteenCell = checkBottomCell{
                let currentFreeCell = gameModel.gameBoard[row][col]
                let cellToSwap = gameModel.gameBoard[row+1][col]
                gameModel.gameBoard[row][col] = cellToSwap
                gameModel.gameBoard[row+1][col] = currentFreeCell
            }
        }
        else if(randInt == 3 && col != 0){
            let checkLeftCell = gameModel.gameBoard[row][col-1].cellType
            if case .fifteenCell = checkLeftCell{
                let currentFreeCell = gameModel.gameBoard[row][col]
                let cellToSwap = gameModel.gameBoard[row][col-1]
                gameModel.gameBoard[row][col] = cellToSwap
                gameModel.gameBoard[row][col-1] = currentFreeCell
            }
        }
        else if(randInt == 4 && col != 3){
            let checkRightCell = gameModel.gameBoard[row][col+1].cellType
            if case .fifteenCell = checkRightCell{
                let currentFreeCell = gameModel.gameBoard[row][col]
                let cellToSwap = gameModel.gameBoard[row][col+1]
                gameModel.gameBoard[row][col] = cellToSwap
                gameModel.gameBoard[row][col+1] = currentFreeCell
        }
    }
        
    }

    
    func shuffleCells(){
        
        
        var numShuffles:Int = 0
        let numTimesToShuffle:Int = Int.random(in: 45...75)
        
        while numShuffles != numTimesToShuffle {
            let randMovementNum = Int.random(in: 1...4)
            
            if(randMovementNum == 1){
                var currFreeSpace = findFreeCell()
                randSpace(row: currFreeSpace.0, col: currFreeSpace.1)
                
                
                numShuffles += 1
            }
            else if(randMovementNum == 2){
                var currFreeSpace = findFreeCell()
                randSpace(row: currFreeSpace.0, col: currFreeSpace.1)

                
                numShuffles += 1
            }
            
            else if(randMovementNum == 3){
                var currFreeSpace = findFreeCell()
                randSpace(row: currFreeSpace.0, col: currFreeSpace.1)

                
                numShuffles += 1
            }
            else if(randMovementNum == 4){
                var currFreeSpace = findFreeCell()
                randSpace(row: currFreeSpace.0, col: currFreeSpace.1)

                
                numShuffles += 1
            }
            
        }
        
        
        
        
////        for shuffle in 0...numShuffles{
////            let randNumber = Int.random(in: 0..<4)
//            var oldSpace = gameModel.gameBoard[2][2]
////            var newSpace = gameModel.gameBoard[3][3]
//            gameModel.gameBoard[2][2] = gameModel.gameBoard[3][3]
//        gameModel.gameBoard[3][3] = oldSpace
            
//        }
    }
    
    func resetCells(){
        let resetNum = 3
        var initNums = 1
        for resets in 0...resetNum{
            for swaps in 0...resetNum{
                gameModel.gameBoard[resets][swaps].cellNumber = initNums
                gameModel.gameBoard[resets][swaps].cellType = CellType.fifteenCell(number: initNums)
                initNums += 1
                if(initNums == 17){
                    gameModel.gameBoard[3][3].cellType = CellType.freeCell
                }
            }
        }
    }
    //When a cell is tapped, checks in all directions to see if a free cell is available to switch with
    func checkCell(row:Int, col:Int){
        if(col != 3){
            let checkRightcell = gameModel.gameBoard[row][col+1].cellType
            if case .freeCell = checkRightcell{

                let currentCell = gameModel.gameBoard[row][col]
                let freeCell = gameModel.gameBoard[row][col+1]
                gameModel.gameBoard[row][col] = freeCell
                gameModel.gameBoard[row][col+1] = currentCell
//                print("moved cell into free space!")
            }
        }
        if(col != 0){
            let checkLeftCell = gameModel.gameBoard[row][col-1].cellType
            if case .freeCell = checkLeftCell{
                let currentCell = gameModel.gameBoard[row][col]
                let freeCell = gameModel.gameBoard[row][col-1]
                gameModel.gameBoard[row][col] = freeCell
                gameModel.gameBoard[row][col-1] = currentCell
//                print("moved cell into free space!")
            }
        }
        if(row != 3){
            let checkBottomCell = gameModel.gameBoard[row+1][col].cellType
            if case .freeCell = checkBottomCell{
                let currentCell = gameModel.gameBoard[row][col]
                let freeCell = gameModel.gameBoard[row+1][col]
                gameModel.gameBoard[row][col] = freeCell
                gameModel.gameBoard[row+1][col] = currentCell
//                print("moved cell into free space!")
            }
        }
        if(row != 0){
            let checkTopCell = gameModel.gameBoard[row-1][col].cellType
            if case .freeCell = checkTopCell{
                let currentCell = gameModel.gameBoard[row][col]
                let freeCell = gameModel.gameBoard[row-1][col]
                gameModel.gameBoard[row][col] = freeCell
                gameModel.gameBoard[row-1][col] = currentCell
//                print("moved cell into free space!")
            }
        }
   
    }
    
    func gamePiece() -> Int{
        let pieceNum = gameModel.getGameCells
        gameModel.getGameCells  += 1
        return pieceNum
    }
}
