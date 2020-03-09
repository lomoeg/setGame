//
//  ViewController.swift
//  SetGame
//
//  Created by Peter Bakholdin on 24.02.2020.
//  Copyright © 2020 Peter Bakholdin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Declarations
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    private lazy var game = Model()
    
    // Ids' of buttons available for setting a card
    private lazy var freebuttonsIdTouched = Array(0...cardButtons.count - 1)
    private var buttonsIdTouched: [Int] = []
    
    private var buttonCardDict = [UIButton: Card]()
    
    private var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...cardButtons.count / 2 - 1 {
            setCard(cardButtonNumber: i)
        }
    }
    
    
    @IBAction private func cardTouched(_ sender: UIButton) {
        if let cardButtonIndex = cardButtons.firstIndex(of: sender) {
            if !buttonsIdTouched.contains(cardButtonIndex) {
                sender.backgroundColor = .orange
                buttonsIdTouched.append(cardButtonIndex)
            } else {
                sender.backgroundColor = .lightGray
                if buttonsIdTouched.firstIndex(of: cardButtonIndex) != nil {
                    buttonsIdTouched.remove(at: buttonsIdTouched.firstIndex(of: cardButtonIndex)!)
                    
                }
            }
            if buttonsIdTouched.count == 4 {
                
                cardButtons[buttonsIdTouched[0]].backgroundColor = .lightGray
                cardButtons[buttonsIdTouched[1]].backgroundColor = .lightGray
                cardButtons[buttonsIdTouched[2]].backgroundColor = .lightGray
                
                // if it is a set
                if game.isThreeCardsIsASet(card1: buttonCardDict[cardButtons[buttonsIdTouched[0]]]!, card2: buttonCardDict[cardButtons[buttonsIdTouched[1]]]!, card3: buttonCardDict[cardButtons[buttonsIdTouched[2]]]!) {
                    
                    // if we are here then we have set
                    deleteThreeCards()
                    score += 5
                    print("Set!")
                } else {
                    // deselect all cards
                    score -= 2
                    buttonsIdTouched.remove(at: 0)
                    buttonsIdTouched.remove(at: 0)
                    buttonsIdTouched.remove(at: 0)
                    print("Not a Set!")
                }
                
                scoreLabel.text = "Score: \(score)"
                
            }
        }
    }
    
    
    private func deleteThreeCards() {
        let question = NSAttributedString(string: "?", attributes: [.strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        cardButtons[buttonsIdTouched[0]].setAttributedTitle(question, for: .normal)
        cardButtons[buttonsIdTouched[1]].setAttributedTitle(question, for: .normal)
        cardButtons[buttonsIdTouched[2]].setAttributedTitle(question, for: .normal)

        buttonCardDict.removeValue(forKey: cardButtons[buttonsIdTouched[0]])
        buttonCardDict.removeValue(forKey: cardButtons[buttonsIdTouched[1]])
        buttonCardDict.removeValue(forKey: cardButtons[buttonsIdTouched[2]])
        
        freebuttonsIdTouched.append(buttonsIdTouched.remove(at: 0))
        freebuttonsIdTouched.append(buttonsIdTouched.remove(at: 0))
        freebuttonsIdTouched.append(buttonsIdTouched.remove(at: 0))
    }
    
    
    // MARK: - New Game button
    @IBAction func newGameButton(_ sender: Any) {
        gameStartPosition()
    }
    
    
    // MARK: - Add 3 more button
    @IBAction func add3MoreCardButton(_ sender: Any) {
        if freebuttonsIdTouched.count > 2 {
            setCard(cardButtonNumber: freebuttonsIdTouched.popLast()!)
            setCard(cardButtonNumber: freebuttonsIdTouched.popLast()!)
            setCard(cardButtonNumber: freebuttonsIdTouched.popLast()!)
        }
    }
    
    
    // MARK: - Clean the code and delete force cast
    private func setCard(cardButtonNumber idx: Int) {
        let card = game.getCard()
        buttonCardDict[cardButtons[idx]] = card
        
        var attributes: [NSAttributedString.Key : Any] = [:]
        
        switch card.feature1 {
        case .value1:
            attributes.updateValue(-20.0, forKey: .strokeWidth)
        case .value2:
            attributes.updateValue(-10.0, forKey: .strokeWidth)
        case .value3:
            attributes.updateValue(-2.0, forKey: .strokeWidth)
        }
        
        switch card.feature2 {
        case .value1:
            attributes.updateValue(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), forKey: .strokeColor)
        case .value2:
            attributes.updateValue(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), forKey: .strokeColor)
        case .value3:
            attributes.updateValue(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), forKey: .strokeColor)
        }
        
        // FIX: - Might crash due to force cast
        switch card.feature3 {
        case .value1:
            attributes.updateValue((attributes[.strokeColor]! as! UIColor).withAlphaComponent(0), forKey: .foregroundColor)
        case .value2:
            attributes.updateValue((attributes[.strokeColor]! as! UIColor).withAlphaComponent(0.5), forKey: .foregroundColor)
        case .value3:
            attributes.updateValue((attributes[.strokeColor]! as! UIColor).withAlphaComponent(1), forKey: .foregroundColor)
        }
        
        var buttonSymbol = NSAttributedString(string: "", attributes: attributes)
        switch card.feature4 {
        case .value1:
            buttonSymbol = NSAttributedString(string: "■", attributes: attributes)
        case .value2:
            buttonSymbol = NSAttributedString(string: "▲", attributes: attributes)
        case .value3:
            buttonSymbol = NSAttributedString(string: "●", attributes: attributes)
        }
        if freebuttonsIdTouched.firstIndex(of: idx) != nil {
            freebuttonsIdTouched.remove(at: freebuttonsIdTouched.firstIndex(of: idx)!)
        }
        cardButtons[idx].setAttributedTitle(buttonSymbol, for: .normal)
    }
    
    
    private func gameStartPosition() {
        score = 0
        scoreLabel.text = "Score: \(score)"
        
        game.newGame()
        
        for button in cardButtons {
            let question = NSAttributedString(string: "?", attributes: [.strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
            button.setAttributedTitle(question, for: .normal)
            button.backgroundColor = .lightGray
        }
        
        buttonsIdTouched = []
        freebuttonsIdTouched = Array(0...cardButtons.count - 1)
        buttonCardDict = [:]
        
        for i in 0...cardButtons.count / 2 - 1 {
            setCard(cardButtonNumber: i)
        }
    }
}

