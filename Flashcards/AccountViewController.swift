//
//  AccountViewController.swift
//  Flashcards
//
//  Created by Julie Connors on 9/7/21.
//

import UIKit

class AccountViewController: UIViewController {
    
    var username : String = "" {
        didSet {
            usernameLabel.text = username
        }
    }
    var email : String = "" {
        didSet {
            emailLabel.text = email
        }
    }
    
    var usernameLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        label.text = "Username"
        return label
    }()
    
    var emailLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 100, y: 150, width: 200, height: 100))
        label.text = "Email"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}
