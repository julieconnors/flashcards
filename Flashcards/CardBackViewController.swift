//
//  CardBackViewController.swift
//  Flashcards
//
//  Created by Julie Connors on 9/9/21.
//

import UIKit

class CardBackViewController: UIViewController {
    
    var descriptionLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        label.text = "Description"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(descriptionLabel)
    }
}
