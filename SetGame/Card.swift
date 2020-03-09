//
//  Card.swift
//  SetGame
//
//  Created by Peter Bakholdin on 04.03.2020.
//  Copyright © 2020 Peter Bakholdin. All rights reserved.
//

import Foundation

struct Card {
    
    //TODO: - Make Card CaseIterable and rewrite == func
    
    let feature1: CardFeatureValues
    let feature2: CardFeatureValues
    let feature3: CardFeatureValues
    let feature4: CardFeatureValues
    
}

enum CardFeatureValues: CaseIterable {
    case value1, value2, value3
}
