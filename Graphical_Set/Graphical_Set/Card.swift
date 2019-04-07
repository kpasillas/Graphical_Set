//
//  Card.swift
//  Graphical_Set
//
//  Created by Work Kris on 4/6/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import Foundation

struct Card
{
    let symbol: Symbol, number: Number, shading: Shading, color: Color
    
    enum Symbol: Character, CaseIterable {
        case triangle = "▲", circle = "●", square = "■"
    }
    
    enum Number: Int, CaseIterable {
        case one = 1, two, three
    }
    
    enum Shading: CaseIterable {
        case solid, striped, open
    }
    
    enum Color: CaseIterable {
        case red, green, purple
    }
}
