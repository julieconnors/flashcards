//
//  CardViewModel.swift
//  Flashcards
//
//  Created by Julie Connors on 9/9/21.
//

import Foundation
import Firebase

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
        let ref = Database.database().reference()
        let refString = "flashcards/"
        
        ref.child(refString).getData(completion: { error, snapshot in
            print(snapshot.value)
            guard let data = snapshot.value else {fatalError()}
            
            let dataDict = data as? NSDictionary
            
            guard let dict = dataDict else {fatalError()}
            
            print(dict)
            
            for (key, value) in dict {
                print("key:", key)
                print("value:", value)
                print(type(of: value))
                
                guard let dict2 = value as? Dictionary<String,Any> else {fatalError()}
                for (key, value) in dict2 {
                    print(key)
                    print(value)
                    print(type(of: value))
                }
                
            }
            
            
            
            
            
            
        })
        
        
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
