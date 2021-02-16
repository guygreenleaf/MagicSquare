//
//  ContentView.swift
//  FifteenPuzzle
//
//  Created by Guy Greenleaf on 2/7/21.
//


//DADF#AD w/WCleanGR5 + reverb + echo

import SwiftUI

struct ContentView: View {
    
    @State private var dragAmnt = CGSize.zero
    
    @ObservedObject var viewModel = FifteenViewModel()
    //2d array to hold the gameboard
    
    var body: some View {


//        Image("Misty")
//            .resizable()
//            .edgesIgnoringSafeArea(.all)
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
                    }
            }
        }
        .background(Image("Misty"))


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
                        
                            
                                           }
                    
            }

        }
    }
    
    
    
    
    func buildCell(rowID: Int, columns: Int) -> some View {
//        let cell:Int = viewModel.getCellNum(row: rowID, col: columns)
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
