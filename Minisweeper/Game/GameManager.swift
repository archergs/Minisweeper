//
//  GameManager.swift
//  Minisweeper
//
//  Created by Archer Gardiner-Sheridan on 16/8/21.
//

import Foundation

class GameManager: ObservableObject{
    
    static var gameInstance = GameManager()
    
    @Published var createdGame: Bool = false
    
    var boardHeight = 7
    var boardWidth = 10
    
    var cells: [[Cell]] = []
    
    func createGame(){
        for y in Range(0...boardWidth - 1){
            cells.append([])
            for x in Range(0...boardHeight - 1){
                cells[y].append(Cell(x: x, y: y))
            }
        }
        
        createdGame = true
    }
    
    func newGame(){
        cells = []
        createGame()
    }
    
    func gameOver(){
        newGame()
    }
}
