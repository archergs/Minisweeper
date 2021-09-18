//
//  Cell.swift
//  Minisweeper
//
//  Created by Archer Gardiner-Sheridan on 16/8/21.
//

import Foundation
import SwiftUI

enum CellState{
    case covered
    case uncovered
    case flagged
}

class Cell : Hashable, ObservableObject {
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    public func hash(into hasher: inout Hasher) {
         hasher.combine(ObjectIdentifier(self))
    }
    
    var identifier = UUID()
    
    // is the cell is a mine
    var isMine: Bool
    // If a cell is a mine, it will have a mine object
    var mine: Mine?
    // has the mine been revealed to the player
    var isRevealed: Bool
    // has the cell been flagged by the player
    @Published var state: CellState
    // if a cell has been selected and it wasn't a mine, this is the number it will show
    var number: Int
    
    // will be green if selected and clear, orange if not selected yet
    @Published var color: Color
    
    // coordinates of the cell on the game board
    var xCoord: Int
    var yCoord: Int
    
    init(x: Int, y: Int) {
        // Randomly choose, for each cell, whether it is a mine
        let rand = Int.random(in: Range(0...10))
        isMine = rand == 10
        
        if isMine{
            mine = Mine(x: x, y: y)
            number = -1
        } else {
            mine = nil
            number = 0
        }
        
        isRevealed = false
        
        state = .covered
        
        color = Color.orange
        
        // Will be changed later
        xCoord = x
        yCoord = y
    }
    
    func cellHasBeenSelected(){
        if (isMine){
            // game over, player clicked on a mine
            GameManager.gameInstance.gameOver()
        } else {
            state = .uncovered
            calculateNumber()
            color = .green
        }
    }
    
    private func calculateNumber(){
        let gm = GameManager.gameInstance
        let cells = gm.cells
        
        var hasAdjacentMine = false
        
        let adjacentCoords = [(xCoord,yCoord-1),
                              (xCoord,yCoord+1),
                              (xCoord+1,yCoord),
                              (xCoord-1,yCoord),
                              (xCoord+1,yCoord-1),
                              (xCoord-1,yCoord-1),
                              (xCoord+1,yCoord+1),
                              (xCoord-1,yCoord+1)]
        
        print("Selected: (\(xCoord),\(yCoord))")
        
        for row in cells{
            for coord in adjacentCoords {
                for cell in row{
                    if cell.xCoord == coord.0 && cell.yCoord == coord.1{
                        if cell.isMine{
                            hasAdjacentMine = true
                            number += 1
                        }
                    }
                }
            }
        }
        
        for row in cells{
            for coord in adjacentCoords {
                for cell in row{
                    if cell.xCoord == coord.0 && cell.yCoord == coord.1{
                        if !cell.isMine && !hasAdjacentMine && cell.state == .covered {
                            cell.cellHasBeenSelected()
                        }
                    }
                }
            }
        }

    }
    
    func toggleFlag(){
        if state == .flagged{
            state = .covered
            return
        }
        if state == .covered{
            state = .flagged
            color = .red
        }
    }
    
}
