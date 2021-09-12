//
//  CardViewModel.swift
//  Flashcards
//
//  Created by Julie Connors on 9/9/21.
//

import Foundation
import Firebase

class CardCollectionViewModel {
    
    var cardVM: [Card]? = [] {
        didSet {
            DispatchQueue.main.async {
                self.updateUI?()
            }
        }
    }
    
    var number: Int {
        cardVM?.count ?? 0
    }
    
    init() {
        getCards()
    }
    
    func setCard(at row: Int) -> Card {
        guard let card = cardVM?[row] else {fatalError()}
        
        return card
    }
    
    func getCards() {
        let ref = Database.database().reference()
        let refString = "flashcards/"
        
        ref.child(refString).getData(completion: { [self] error, snapshot in
            guard let data = snapshot.value else { return }
            
            let dataDict = data as? NSDictionary
            
            guard let dict = dataDict else { return }
                        
            var cards: [Card] = []
            for (_, value) in dict {
                guard let dict2 = value as? Dictionary<String,Any> else {fatalError()}
                for (key, value) in dict2 {
                    let newKey = key
                    let newValue = (value as? String) ?? ""
                
                    let newCard = Card(headline: newKey, description: newValue)
                    
                    cards.append(newCard)
                }
            }
            cardVM = cards
        })
    }
    
    func addCardToDB(card: Card) {
        let ref = Database.database().reference()
        let refString = "flashcards/" + card.headline.lowercased()
        
        if card.headline != "" || card.description != "" {
            ref.child(refString).getData { error, snapshot in
                if snapshot.exists() {
                } else {
                    ref.child(refString).setValue([
                        card.headline.lowercased(): card.description.lowercased(),
                    ])
                }
            }
        }
    }
    
    func deleteCard(headline: String) {
        guard let vm = cardVM else { return }
        let remaining = vm.filter {$0.headline != headline}
        cardVM = remaining

        let ref = Database.database().reference()
        let refString = "flashcards/" + headline
        
        ref.child(refString).removeValue()
    }
    
    func bind(completion: @escaping () -> Void) {
        self.updateUI = completion
    }
    
    var updateUI: (() -> Void)?
    
}

extension CardCollectionViewModel: CreateCardProtocol {
    func addCard(card: Card) {
        cardVM?.append(card)
    }
}

