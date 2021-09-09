//
//  CardViewModel.swift
//  Flashcards
//
//  Created by Julie Connors on 9/9/21.
//

import Foundation

class CardCollectionViewModel {
    
    var cardVM: [Card]? {
        didSet {
            DispatchQueue.main.async {
                self.updateUI?()
            }
        }
    }
    
    var number: Int {
        cardVM?.count ?? 0
    }
    
    let cards: [Card] = [Card(headline: "generics", description: "allows for multiple types"), Card(headline: "protocol", description: "object blueprint"), Card(headline: "extension", description: "continuation of object definition, cannot store values")]
    
    init() {
        getCards()
    }
    
    func setCard(at row: Int) -> Card {
        guard let card = cardVM?[row] else {fatalError()}
        
        return card
    }
    
    
    
    func getCards() {
        //get from db, save to cards vm
        
        cardVM = cards
    }
    
    func addCard() {
        //add to cards vm and persist to db
    }
    
    func bind(completion: @escaping () -> Void) {
        self.updateUI = completion
    }
    
    var updateUI: (() -> Void)?
}
