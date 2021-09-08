//
//  ViewController.swift
//  Flashcards
//
//  Created by Julie Connors on 9/7/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let usernameLabel = UILabel()
    let emailLabel = UILabel()
    
    let usernameTextfield = UITextField()
    let emailTextfield = UITextField()
    
    let signinButton = UIButton()
    let createUserButton = UIButton()
    let useAsGuestButton = UIButton()
    
    let errorLabel = UILabel()
    
    var errorString : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view = UIView()
        view.backgroundColor = .white
        addSubView()
        setupConstraints()
        createUser(email: "bryan@gmail.com", username: "bryan2")
    }
    
    func addSubView() {
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        view.addSubview(usernameTextfield)
        view.addSubview(emailTextfield)
        view.addSubview(signinButton)
        view.addSubview(createUserButton)
        view.addSubview(useAsGuestButton)
        view.addSubview(errorLabel)
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextfield.translatesAutoresizingMaskIntoConstraints = false
        emailTextfield.translatesAutoresizingMaskIntoConstraints = false
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        createUserButton.translatesAutoresizingMaskIntoConstraints = false
        useAsGuestButton.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        func setupUsernameConstraints() {
            usernameLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20).isActive = true
            usernameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
            usernameLabel.text = "Username: "
            usernameLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
            
            usernameTextfield.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20).isActive = true
            usernameTextfield.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 0).isActive = true
            usernameTextfield.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
            usernameTextfield.borderStyle = UITextField.BorderStyle.roundedRect

        }
        
        func setupEmailConstraints() {
            emailLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 20).isActive = true
            emailLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
            emailLabel.text = "Email: "
            emailLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
            
            emailTextfield.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 20).isActive = true
            emailTextfield.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 0).isActive = true
            emailTextfield.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
            emailTextfield.borderStyle = UITextField.BorderStyle.roundedRect
        }
        
        func setupSigninConstraints() {
            signinButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 70).isActive = true
            signinButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
            signinButton.setTitle("Sign In" , for: .normal)
            signinButton.backgroundColor = .yellow
            signinButton.setTitleColor(.systemTeal, for: .normal)
            signinButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        }
        
        func setupCreateUserContraints() {
            createUserButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 110).isActive = true
            createUserButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
            createUserButton.setTitle("Create User" , for: .normal)
            createUserButton.backgroundColor = .yellow
            createUserButton.setTitleColor(.systemTeal, for: .normal)
            createUserButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        }
        
        func setupUseAsGuestContraints() {
            useAsGuestButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 150).isActive = true
            useAsGuestButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
            useAsGuestButton.setTitle("Use As Guest" , for: .normal)
            useAsGuestButton.backgroundColor = .yellow
            useAsGuestButton.setTitleColor(.systemTeal, for: .normal)
            useAsGuestButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        }
        
        func setupErrorLabelConstrains() {
            errorLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -60).isActive = true
            errorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
            errorLabel.text = errorString
            errorLabel.textColor = .red
        }
        
        setupUsernameConstraints()
        setupEmailConstraints()
        setupSigninConstraints()
        setupCreateUserContraints()
        setupUseAsGuestContraints()
        setupErrorLabelConstrains()
    }
    
    
    
    
    
    func createUser(email: String, username: String) {
        let ref = Database.database().reference()
        let refString = "users/" + username.lowercased()
        var newEmail = email.replacingOccurrences(of: "@", with: "")
        newEmail = newEmail.replacingOccurrences(of: ".", with: "")
        let emailRefString = "emails/" + newEmail.lowercased()
        
        if email == nil || username == nil {
            errorString = "fields must not be empty"
//            view.setNeedsDisplay()
        }
        
        
        
        ref.child(refString).getData { error, snapshot in
            if snapshot.exists() {
                print("username exists")
            } else {
                ref.child(emailRefString).getData { error, snapshot2 in
                    if snapshot2.exists() {
                        print("email exists")
                    } else {
                        print("creating")
                        ref.child(emailRefString).setValue([
                            newEmail: username,
                        ])
                        ref.child(refString).setValue([
                            username: email,
                        ])
                    }
                }
                
            }
        }
    }


}

