//
//  CreateCardViewController.swift
//  Flashcards
//
//  Created by Julie Connors on 9/7/21.
//

import UIKit
import Firebase

//protocol CreateCardProtocol {
//    func addCard(card: Card)
//}

class CreateCardViewController: UIViewController {
    var collectionViewModel: CardCollectionViewModel?

    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var headline: UITextField!
    @IBOutlet weak var cardDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonAndDescription()
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
        collectionViewModel?.addCard(card: card)
        collectionViewModel?.addCardToDB(card: card)
        
        headline.text = ""
        cardDescription.text = ""
    }
}


