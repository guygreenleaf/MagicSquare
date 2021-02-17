//
//  ContentView.swift
//  FifteenPuzzle
//
//  Created by Guy Greenleaf on 2/7/21.
//



import SwiftUI

struct ContentView: View {


    @State private var showStart = true
    @State private var showWin = false
    @ObservedObject var viewModel = FifteenViewModel()
 
    var body: some View {

        ZStack{
            if(!showStart){
        VStack{


            buildGameView(rows: viewModel.gameSize().rows, columns: viewModel.gameSize().columns)
            .animation(.spring())
            .padding()
                
            HStack{
            Text("Shuffle")
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .border(Color.blue, width: 5)
                .cornerRadius(10)
                .onTapGesture {
                    viewModel.isPlaying = true
                    viewModel.shuffleCells()
                    
                }
                Text("Reset")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .border(Color.blue, width: 5)
                    .cornerRadius(10)
                    .onTapGesture {
                        viewModel.resetCells()
                        viewModel.isPlaying = false
                        
                    }
                
            }
            Text("Menu")
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .border(Color.blue, width: 5)
                .cornerRadius(10)
                .onTapGesture {
                    viewModel.resetCells()
                    viewModel.isPlaying = false 
                    withAnimation{
                        showStart.toggle()
                    }
                }
        }
            
        .background(Image("Misty"))
        .transition(.slide)
            }
            if(showStart){
                ZStack{
                    Spacer()
            VStack{
                Text("Welcome!")
                    .padding()
                    .foregroundColor(Color.white)
                    .scaleEffect(2)
                Text("On the next screen, choose 'Shuffle' to start a game")
                    .padding()
                    .foregroundColor(Color.white)
                    .scaleEffect(1)
                Text("Move a cell into the empty space by tapping on the cell you want to move")
                    .padding()
                    .foregroundColor(Color.white)
                    .scaleEffect(1)
                Text("Order all cells from 1 to 15 in order to win the game")
                    .padding()
                    .foregroundColor(Color.white)
                    .scaleEffect(1)
                Text("Begin")
                    .fontWeight(.bold)
                    
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .border(Color.blue, width: 2)
                    .cornerRadius(10)
                    .onTapGesture {
                        withAnimation{
                            showStart.toggle()
                        }
                    }


                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)

            .transition(.slide)
            .background(Color.black)
            .ignoresSafeArea()
                }
      
            }
            
            if(showWin){
                VStack{
                    Text("You win!!!!")
                        .padding()
                        .foregroundColor(Color.white)
                        .scaleEffect(2)
                    Text("Return to menu")
                        .fontWeight(.bold)
                        
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .border(Color.blue, width: 2)
                        .cornerRadius(10)
                        .onTapGesture {
                            viewModel.userWon = false

                            withAnimation{
                                showWin.toggle()
                                showStart.toggle()
                            }
                        }

                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)

                .background(Color.black)
                .ignoresSafeArea()
                .transition(.slide)
            }
        }
        
        



    }
    
    func winChecker(){
        if(viewModel.isPlaying && viewModel.didWinGame()){
            viewModel.isPlaying = false
            showWin = true
        }
    }
    
    func buildGameView(rows: Int, columns: Int) -> some View {
        return VStack {
            ForEach(0..<rows, content: { idx in
                return buildGameRow(rowID: idx, columns: columns)
                
                
            })
        }
    }
    
    
    func buildGameRow(rowID: Int, columns: Int) -> some View {
        return HStack{
            ForEach(0..<columns) {idx in
        
                buildCell(rowID: rowID, columns: idx)
                    

                    .onTapGesture {
                        viewModel.didTapCell(row: rowID , col: idx)
                        winChecker()
                                }
                            }
                        }
                    }
    
    
    
    
    func buildCell(rowID: Int, columns: Int) -> some View {
        let bigTest = viewModel.getCell(row: rowID, col: columns)
        return  ZStack{

             RoundedRectangle(cornerRadius:cornerRadiusForCell)
                .frame(width:90, height: 90)

                .foregroundColor(Color.blue)
                .border(Color.black, width:3.5)
                .cornerRadius(5)
                
  
            bigTest.cellNumber != 16 ? Text(String(bigTest.cellNumber)) : Text("")
        }
        .font(Font.headline)
        
        .onTapGesture {
             viewModel.checkCell(row: rowID, col: columns)
            viewModel.setCellDidWinArray()
            winChecker()

        }


    }
    


}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
var cornerRadiusForCell: CGFloat = 10.0
let strokeLineWidth : CGFloat = 1.0
