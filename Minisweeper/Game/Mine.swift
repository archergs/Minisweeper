//
//  Mine.swift
//  Minisweeper
//
//  Created by Archer Gardiner-Sheridan on 16/8/21.
//

import Foundation

struct Mine: Hashable{
    
    var identifier = UUID()
    
    var xCoord: Int
    var yCoord: Int
    
    static func == (lhs: Mine, rhs: Mine) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init(x: Int, y: Int){
        xCoord = x
        yCoord = y
    }
    
}
