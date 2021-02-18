//
//  FifteenViewModel.swift
//  FifteenPuzzle
//
//  Created by Guy Greenleaf on 2/7/21.
//

import Foundation

class FifteenViewModel: ObservableObject{
    //Keep track of if the user is playing the game
     var isPlaying = false
    //Keep track of if the user has won the game
     var userWon = false
    //Array to update to keep track of if the user has won the game
    var arrWon:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    //Bridge between model and view
    
    
    @Published var gameModel = FifteenModel()
    //viewmodel initializer
    init(){
        gameModel.createGameFor( rows: 4, columns: 4 )
    }
    //get game size
    func gameSize() -> (rows: Int, columns: Int){
    return gameModel.gameSize()
    }
    //get the game cells
    func getGamePiece() -> Int{
        return gameModel.getGameCells
    }
    //check if the user taps a cell [used for testing]
    func didTapCell(row: Int, col: Int) {
        print("View: Tapped a \(gameModel.getCellType(row: row, col: col))")
        
    }
    //get a particular cell if need be
    func getCell(row: Int, col: Int) -> BoardCell{
        return gameModel.gameBoard[row][col]
    }
    //get the number of a cell
    func getCellNum(row:Int, col:Int)->Int{
        return gameModel.gameBoard[row][col].cellNumber
    }
    //scan the board and find the current free cell
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
    
    //Selects a number 1-4 to represent up, down, left, or right
    //Then, checks if there's a space to move to.
    //If there is, swaps the free cell with the adjacent cell.
    //This makes it so that the maze is solvable, as it simulates human movement by being restricted to only swapping
    //cells that are directly adjacent up, down, left, or right of the current free cell with the free cell!
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
    
    
    //Sets the arrWon array to the current orientation of the game board
    func setCellDidWinArray(){
        var arrSpace = 0
        for i in 0...3{
            for j in 0...3{
            arrWon[arrSpace] = gameModel.gameBoard[i][j].cellNumber
                arrSpace += 1
            }
        }
    }
    
    //Function that checks if the user has won the game every time the user moves
    func didWinGame()->Bool{
        for nums in 0...15{
            if(arrWon[nums] != nums+1){
                return false
            }
        }
        return true
    }
    
    
    func shuffleCells(){
        
        //var to represent the current number of shuffles
        var numShuffles:Int = 0
        //Shuffle the board 50-100 times.  In future versions of the program, this could be passed into the function
        //as an enum to represent 'easy', 'medium', or 'hard', and the user could set that enum in the main menu to choose how many times the board gets shuffled according to what's chosen.
        
        //NOTE: If you'd like to see how winning the game behaves,
        //you can change this value to something small like 2 or 3 and quickly
        //solve the puzzle
        let numTimesToShuffle:Int = Int.random(in: 50...100)
        
        //While the number of current shuffles is not the times to shuffle
        while numShuffles != numTimesToShuffle {
            //Find the current free space.
                let currFreeSpace = findFreeCell()
            //call randSpace function and pass the current free space to it
                randSpace(row: currFreeSpace.0, col: currFreeSpace.1)
            //increment the number of shuffles
                numShuffles += 1
        }
        //Orient the game board to start keeping track of if the user has won or not
        setCellDidWinArray()
    }
    
    //Resets the game board to the initial position
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
