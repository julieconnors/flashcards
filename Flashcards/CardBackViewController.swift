//
//  CardBackViewController.swift
//  Flashcards
//
//  Created by Julie Connors on 9/9/21.
//

import UIKit

class CardBackViewController: UIViewController {
    //view model
    
    var viewModel: CardCollectionViewModel?
    
    var labelDescription: String = "" {
        didSet {
            descriptionLabel.text = labelDescription
        }
    }
    
    var deleteButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
        button.setTitle("Delete", for: .normal)
        button.addTarget(self, action: #selector(removeCard), for: .touchUpInside)
        return button
    }()
    
    @objc func removeCard() {
        viewModel = CardCollectionViewModel()
        
        print("delete card")
    }
    
    var descriptionLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(descriptionLabel)
        view.addSubview(deleteButton)
    }
}
