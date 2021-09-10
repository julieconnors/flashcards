//
//  CardViewModel.swift
//  Flashcards
//
//  Created by Julie Connors on 9/10/21.
//

import Foundation

class CardViewModel {
    var cardModel: Card {
        didSet {
            DispatchQueue.main.async {
                self.updateUIClosure?()
            }
        }
    }

    init(card: Card) {
        self.cardModel = card
    }

    func bind(completion: @escaping () -> Void) {
        self.updateUIClosure = completion
    }
    
    var updateUIClosure: (() -> Void)?

    var headline: String {
        cardModel.headline
    }
    
    var description: String {
        cardModel.description
    }
}
