//
//  CreateCardViewController.swift
//  Flashcards
//
//  Created by Julie Connors on 9/7/21.
//

import UIKit
import Firebase

class CreateCardViewController: UIViewController {

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
        
        createCard(headline: headlineInput, description: descriptionInput)
    }
    
    
    func createCard(headline: String!, description: String!) {
        let ref = Database.database().reference()
        let refString = "flashcards/" + headline.lowercased()
        let headlineUnwrapped = headline ?? ""
        let descriptionUnwrapped = description ?? ""
        
        if headline != nil || description != nil || headline != "" || description != "" {
            ref.child(refString).getData { error, snapshot in
                if snapshot.exists() {
                } else {
                    ref.child(refString).setValue([
                        headlineUnwrapped.lowercased(): descriptionUnwrapped.lowercased(),
                    ])
                }
            }
        }
    }
}
