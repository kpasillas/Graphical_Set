//
//  CardsLayoutView.swift
//  Graphical_Set
//
//  Created by Work Kris on 5/16/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import UIKit

class CardsLayoutView: UIView {
    
//    private lazy var cardArray = createCardArray()
    var cardArray = [CardView]() { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    private lazy var cardGrid = Grid(layout: .aspectRatio(5/8), frame: CGRect.zero)
    
    private func configureCardArray(_ cards: [CardView]) {
        
        cardGrid.frame = self.bounds
        cardGrid.cellCount = cards.count
        
        for index in cards.indices {
            cards[index].frame = cardGrid[index]!.inset(by: cardGrid.CardInsetSize)
            addSubview(cards[index])
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
     
//        print("In CardsLayoutView -> layoutSubviews")

        configureCardArray(cardArray)
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension Grid {
    struct SizeRatio {
        static let CardInsetRatio: CGFloat = 0.04
    }
    var CardInsetSize: CGSize {
        return CGSize(width: self.cellSize.width * SizeRatio.CardInsetRatio, height: self.cellSize.height * SizeRatio.CardInsetRatio)
    }
}
