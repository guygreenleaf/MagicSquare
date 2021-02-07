//
//  ContentView.swift
//  FifteenPuzzle
//
//  Created by Guy Greenleaf on 2/7/21.
//

import SwiftUI

struct ContentView: View {
    
    var viewModel = FifteenViewModel()
    
    var body: some View {
        buildGameView(rows: viewModel.gameSize().rows, columns: viewModel.gameSize().columns)
            .padding()
    }
    
    
    func buildGameView(rows: Int, columns: Int) -> some View {
        return VStack {
            ForEach(0..<rows, content: { idx in
                
                return buildGameRow(columns: columns)
            })
        }
    }
    
    
    func buildGameRow(columns: Int) -> some View {
        return HStack{
            ForEach(0..<columns) {idx in
                buildCell()
            }
        }
    }
    
    
    
    
    func buildCell() -> some View {
      
        return ZStack{
            RoundedRectangle(cornerRadius:
                                cornerRadiusForCell).foregroundColor(Color.blue)
            RoundedRectangle(cornerRadius: cornerRadiusForCell).stroke(lineWidth: strokeLineWidth)
            if(viewModel.getGamePiece() != 15){
            Text(String(viewModel.gamePiece()))
            }
            else{
                Text("")
            }
        }
        .font(Font.headline)
    }
    
    
    let cornerRadiusForCell: CGFloat = 10.0
    let strokeLineWidth : CGFloat = 1.0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
