//
//  Model.swift
//  SetGame
//
//  Created by Peter Bakholdin on 06.03.2020.
//  Copyright © 2020 Peter Bakholdin. All rights reserved.
//

import Foundation

class Model {
    
    private var cardsArray: [Card] = {
        var cardsArray = [Card]()
        for feature_first in CardFeatureValues.allCases {
            for feature_second in CardFeatureValues.allCases {
                for feature_third in CardFeatureValues.allCases {
                    for feature_fourth in CardFeatureValues.allCases {
                        
                        cardsArray.append(Card(feature1: feature_first, feature2: feature_second, feature3: feature_third, feature4: feature_fourth))
                        
                    }
                }
            }
        }
        return cardsArray.shuffled()
    }()
    
    private var сardsOnTheDesk = [Card]()
    
    //didSet?
    //index for cardsArray, needed to choose new card every time we want to put card on the table
    private var allCardsIndex = 0
    
    func newGame() {
        allCardsIndex = 0
        сardsOnTheDesk = []
        cardsArray.shuffle()
    }
    
    
    // MARK: - Get card to the table function
    func getCard() -> Card {
        let card = cardsArray[allCardsIndex]
        if allCardsIndex < cardsArray.count {
            allCardsIndex += 1
        } else {
            return cardsArray[0]
        }
        сardsOnTheDesk.append(card)
        return card
    }
    
    
    // MARK: Check if 3 cards is a set
    func isThreeCardsIsASet(card1: Card, card2: Card, card3: Card) -> Bool {
        let res12 = isTwoCardsAPotentionalSet(card1: card1, card2: card2)
        let res13 = isTwoCardsAPotentionalSet(card1: card1, card2: card3)
        let res23 = isTwoCardsAPotentionalSet(card1: card2, card2: card3)
       
        print(card1)
        print(card2)
        print(card3)
        print("\n")
        
        if isTwoArraysContainsOnlyOneSameElement(array1: res12, array2: res13) == isTwoArraysContainsOnlyOneSameElement(array1: res12, array2: res23), isTwoArraysContainsOnlyOneSameElement(array1: res13, array2: res23) == isTwoArraysContainsOnlyOneSameElement(array1: res12, array2: res13), isTwoArraysContainsOnlyOneSameElement(array1: res12, array2: res13) != nil {
            
            return true
        } else {
            return false
        }
    }
    
    
    private func isTwoCardsAPotentionalSet (card1: Card, card2: Card) -> [Int] {
        var equalCaseCount = [Int]()
        if card1.feature1 == card2.feature1 {
            equalCaseCount.append(1)
        }
        if card1.feature2 == card2.feature2 {
            equalCaseCount.append(2)
        }
        if card1.feature3 == card2.feature3 {
            equalCaseCount.append(3)
        }
        if card1.feature4 == card2.feature4 {
            equalCaseCount.append(4)
        }
        
        return equalCaseCount
    }
    
    
    private func isTwoArraysContainsOnlyOneSameElement(array1: [Int], array2: [Int]) -> Int? {
        let m = min(array1.count, array2.count)
        var count = 0
        var equalIdx = -1
        for i in 0..<m {
            if array1[i] == array2[i] {
                count += 1
                equalIdx = array2[i]
            }
        }
        
        if count == 1, array1.count == 1, array2.count == 1 {
            return equalIdx
        } else { return nil }
    }
    
    
}
