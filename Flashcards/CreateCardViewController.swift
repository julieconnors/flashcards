//
//  CreateCardViewController.swift
//  Flashcards
//
//  Created by Julie Connors on 9/7/21.
//

import UIKit
import Firebase

class CreateCardViewController: UIViewController, CollectionDelegate {
    var cardCollection: [Card] = []
    
    var collectionViewModel: CardCollectionViewModel?
    
    var collectionDelegate: CollectionDelegate?


    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var headline: UITextField!
    @IBOutlet weak var cardDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonAndDescription()
        
        guard let cards = collectionDelegate?.cardCollection else { return }
        cardCollection = cards
    }
    
    func configureButtonAndDescription() {
        createButton.addTarget(self, action: #selector(createPressed), for: .touchUpInside)
        cardDescription.textAlignment = .left
        cardDescription.contentVerticalAlignment = .top
    }
    
    @objc func createPressed() {
        let headlineInput : String!  = headline.text?.lowercased()
        let descriptionInput : String!  = cardDescription.text?.lowercased()
        let card = Card(headline: headlineInput, description: descriptionInput)
        
        addCardToCollection(card: card)
    }
    
    func addCardToCollection(card: Card) {
        collectionViewModel = CardCollectionViewModel()
        
        cardCollection.append(card)

        print(cardCollection)
        
//        collectionViewModel?.cardVM = cardCollection

        collectionViewModel?.addCardToDB(card: card)
    }
}

