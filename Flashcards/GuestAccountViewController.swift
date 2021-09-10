//
//  GuestAccountViewController.swift
//  Flashcards
//
//  Created by Julie Connors on 9/8/21.
//

import UIKit

class GuestAccountViewController: UIViewController {
    let myColor = #colorLiteral(red: 0.9238926768, green: 0.770031631, blue: 0.9872184396, alpha: 1)
    
    let label = UILabel()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = myColor
        addSubview()
    }
    
    func addSubview() {
        view.addSubview(label)
        view.addSubview(button)
        labelConstraints()
        buttonConstraints()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func labelConstraints() {
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        label.widthAnchor.constraint(equalToConstant: 120).isActive = true
        label.text = "Please sign in"
        label.font = .systemFont(ofSize: 18, weight: .medium)
    }
    
    func buttonConstraints() {
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 30).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.setTitle("Go back to login", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
    }
    
    @objc func goToLogin() {
        self.dismiss(animated: true, completion: nil)
    }
}
