//
//  ContentView.swift
//  Minisweeper
//
//  Created by Archer Gardiner-Sheridan on 16/8/21.
//

import SwiftUI

struct GameCell: View {
    
    @ObservedObject var cell: Cell
    
    var body: some View{
        ZStack{
            Rectangle()
                .foregroundColor(cell.color)
                .border(Color.red, width: 2)
                .frame(width: 40, height: 40, alignment: .center)
            if(cell.isMine && GameManager.gameInstance.easyMode){
                Text("M")
            } else if cell.state == .uncovered{
                Text("\(cell.adjacentMines)")
            } else if cell.state == .flagged{
                Text("F")
            }
        }
    }
}

struct GameView: View {
    
    @ObservedObject var gm = GameManager.gameInstance
    
    let columns = [
        GridItem(.fixed(30)),
        GridItem(.fixed(30)),
        GridItem(.fixed(30)),
        GridItem(.fixed(30)),
        GridItem(.fixed(30)),
        GridItem(.fixed(30)),
        GridItem(.fixed(30)),
    ]
    
    var body: some View {
        VStack{
            HStack{
                Text("Minisweeper")
                    .fontWeight(.medium)
                    .font(.title)
                
                Button(action: {
                    gm.newGame()
                }, label: {
                    Image(systemName: "arrow.counterclockwise.circle")
                })
            }
            if gm.createdGame{
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(gm.cells, id: \.self) { row in
                        ForEach(row, id: \.self) { cell in
                            GameCell(cell: cell)
                                .onTapGesture(count: 2) {
                                    cell.toggleFlag()
                                }
                                .onTapGesture(perform: {
                                    cell.cellHasBeenSelected()
                                })
                        }
                    }
                }.padding(.horizontal)
                .frame(width: 300, height: 400, alignment: .center)
            }
        }.onAppear(perform: {
            gm.createGame()
        })
        .frame(width: 300, height: 480, alignment: .center)
    }
    
    func singleClick(cell: Cell){
        print("Selected: (\(cell.xCoord),\(cell.yCoord))")
        cell.cellHasBeenSelected()
    }
    
    func doubleClick(cell: Cell){
        print("double")
        cell.toggleFlag()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
