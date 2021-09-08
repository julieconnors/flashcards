//
//  GuestAccountViewController.swift
//  Flashcards
//
//  Created by Julie Connors on 9/8/21.
//

import UIKit

class GuestAccountViewController: UIViewController {
    let myColor = #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = myColor
        view.addSubview(label)
        view.addSubview(button)
    }
    
    var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))

        label.text = "Please sign in"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    var button: UIButton = {
        let button = UIButton()
        //set text
        //add constraints
        return button
    }()
}
