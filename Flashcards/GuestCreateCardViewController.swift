//
//  GuestCreateCardViewController.swift
//  Flashcards
//
//  Created by Julie Connors on 9/8/21.
//

import UIKit

class GuestCreateCardViewController: UIViewController {
    
    let myColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = myColor
        addSubview()
    }
    
    func addSubview() {
        view.addSubview(label)
        view.addSubview(button)
    }
    
    var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))

        label.text = "Please sign in"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 80, y: 100, width: 150, height: 200))
        button.setTitle("Go back to login", for: .normal)
        
        return button
    }()
}
