//
//  Cell.swift
//  Minisweeper
//
//  Created by Archer Gardiner-Sheridan on 16/8/21.
//

import Foundation
import SwiftUI

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
    var isFlagged: Bool
    
    // will be green if selected and clear, orange if not selected yet
    @Published var color: Color
    
    // coordinates of the cell on the game board
    var xCoord: Int
    var yCoord: Int
    
    init(x: Int, y: Int) {
        // Randomly choose, for each cell, whether it is a mine
        isMine = Bool.random()
        
        if isMine{
            mine = Mine(x: x, y: y)
        } else {
            mine = nil
        }
        
        isRevealed = false
        
        isFlagged = false
        
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
            print("tap")
            color = .green
        }
    }
    
}
