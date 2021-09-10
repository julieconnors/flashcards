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
    
    var deleteButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
        button.setTitle("Delete", for: .normal)
        button.addTarget(self, action: #selector(removeCard), for: .touchUpInside)
        return button
    }()
    
    @objc func removeCard() {
        guard let cardArray = collectionViewModel?.cardVM else { return }
        let remaining = cardArray.filter {$0.headline != cardViewModel?.headline}
        
        collectionViewModel?.cardVM = remaining
        collectionViewModel?.deleteCard(headline: cardViewModel?.headline ?? "")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    var descriptionLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = cardViewModel?.description
        view.backgroundColor = .orange
        view.addSubview(descriptionLabel)
        view.addSubview(deleteButton)
    }
}
