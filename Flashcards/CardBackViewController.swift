//
//  CardBackViewController.swift
//  Flashcards
//
//  Created by Julie Connors on 9/9/21.
//

import UIKit

class CardBackViewController: UIViewController {
    var cardViewModel: CardViewModel?
    var collectionViewModel: CardCollectionViewModel?
    
    let myColor = #colorLiteral(red: 0.6686105728, green: 0.9985826612, blue: 0.7362037301, alpha: 1)
    
    var descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = cardViewModel?.description
        view.backgroundColor = myColor
        view.addSubview(descriptionLabel)
        view.addSubview(deleteButton)
        labelConstraints()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func labelConstraints() {
        descriptionLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
    var deleteButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
        button.setTitle("Delete", for: .normal)
        button.addTarget(self, action: #selector(removeCard), for: .touchUpInside)
        button.setTitleColor(.gray, for: .normal)

        return button
    }()
    
    @objc func removeCard() {
        guard let cardArray = collectionViewModel?.cardVM else { return }
        let remaining = cardArray.filter {$0.headline != cardViewModel?.headline}
        
        collectionViewModel?.cardVM = remaining
        collectionViewModel?.deleteCard(headline: cardViewModel?.headline ?? "")
        
        self.dismiss(animated: true, completion: nil)
    }
}
