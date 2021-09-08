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
    
    var errorLabel = UILabel()
    
    var errorString : String = "" {
        didSet {
            errorLabel.text = errorString
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view = UIView()
        view.backgroundColor = .white
        addSubView()
        setupConstraints()
        createUser(email: "bryan@gmail.com", username: "bryan2")
        useAsGuestButton.addTarget(self, action: #selector(guestMode), for: .touchUpInside)
    }
    
    @objc func guestMode() {
        let tabBarVC = UITabBarController()
        
        let cardSB = UIStoryboard(name: "Cards", bundle: nil)
        let cardsController = cardSB.instantiateViewController(identifier: "CardsVC")

        let vc1 = cardsController
        vc1.title = "Cards"
        
        let vc2 = GuestAccountViewController()
        vc2.title = "Account"
        let vc3 = GuestCreateCardViewController()
        vc3.title = "Create"
        tabBarVC.setViewControllers([vc1, vc2, vc3], animated: true)
        
        guard let items = tabBarVC.tabBar.items else { return }
        
        let images = ["square.grid.2x2", "person", "pencil.circle"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
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
            
            signinButton.addTarget(self, action: #selector(pressedLogin), for: .touchUpInside)
        }
        
        func setupCreateUserContraints() {
            createUserButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 110).isActive = true
            createUserButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
            createUserButton.setTitle("Create User" , for: .normal)
            createUserButton.backgroundColor = .yellow
            createUserButton.setTitleColor(.systemTeal, for: .normal)
            createUserButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
            
            createUserButton.addTarget(self, action: #selector(pressedCreateUser), for: .touchUpInside)
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
            print("errorlabel: \(errorString)")
            errorLabel.textColor = .red
        }
        
        setupUsernameConstraints()
        setupEmailConstraints()
        setupSigninConstraints()
        setupCreateUserContraints()
        setupUseAsGuestContraints()
        setupErrorLabelConstrains()
    }
    
    @objc func pressedCreateUser() {
        let userUsername : String!  = usernameTextfield.text
        let userEmail : String!  = emailTextfield.text
        
        createUser(email: userEmail, username: userUsername)
    }
    
    
    func createUser(email: String!, username: String!) {
        let ref = Database.database().reference()
        let refString = "users/" + username.lowercased()
        
        let atSet = CharacterSet.init(charactersIn: "@")
        let periodSet = CharacterSet.init(charactersIn: ".")

        if email == nil || username == nil || email == "" || username == "" {
            self.errorString = "fields must not be empty"
//            print("nil")
        } else {
            var newEmail = email.replacingOccurrences(of: "@", with: "")
            newEmail = newEmail.replacingOccurrences(of: ".", with: "")
            let emailRefString = "emails/" + newEmail.lowercased()
            if (email.rangeOfCharacter(from: atSet) != nil) && (email.rangeOfCharacter(from: periodSet) != nil) {
//                print("contains both")
                ref.child(refString).getData { error, snapshot in
                    if snapshot.exists() {
                        self.errorString = "username already exists"
//                        let value = snapshot.value as? NSDictionary
//                        let usernameData = value?["\(username.lowercased())"] ?? ""
//                        let usernameDataStr = (usernameData as? String) ?? ""
//                        let emailStr = email ?? ""
//                        print(usernameDataStr)
//                        print(emailStr)
//                        if usernameDataStr == emailStr.lowercased() {
//                            print(usernameDataStr)
//                        }
                    } else {
                        ref.child(emailRefString).getData { error, snapshot2 in
                            if snapshot2.exists() {
//                                print("email exists")
                                self.errorString = "email already exists"
                            } else {
//                                print("creating")
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
            } else {
                print("invalid email")
                self.errorString = "email is invalid"
            }
        }
    }
    
    @objc func pressedLogin() {
        let userUsername : String!  = usernameTextfield.text
        let userEmail : String!  = emailTextfield.text
        
        login(email: userEmail, username: userUsername)
    }
    
    
    func login(email: String!, username: String!) {
        let ref = Database.database().reference()
        let refString = "users/" + username.lowercased()
        
        let atSet = CharacterSet.init(charactersIn: "@")
        let periodSet = CharacterSet.init(charactersIn: ".")

        if email == nil || username == nil || email == "" || username == "" {
            self.errorString = "fields must not be empty"
            print("nil")
        } else {
            var newEmail = email.replacingOccurrences(of: "@", with: "")
            newEmail = newEmail.replacingOccurrences(of: ".", with: "")
            let emailRefString = "emails/" + newEmail.lowercased()
            if (email.rangeOfCharacter(from: atSet) != nil) && (email.rangeOfCharacter(from: periodSet) != nil) {
                print("contains both")
                ref.child(refString).getData { error, snapshot in
                    if snapshot.exists() {
//                        self.errorString = "username already exists"
                        print("username exists")
                        let value = snapshot.value as? NSDictionary
                        let usernameData = value?["\(username.lowercased())"] ?? ""
                        let usernameDataStr = (usernameData as? String) ?? ""
                        let emailStr = email ?? ""
                        if usernameDataStr == emailStr.lowercased() {
                            print(usernameDataStr)
                            print("login success")
                            
                        }
                    } else {
//                        let value = snapshot.value as? NSDictionary
//                        let usernameData = value?["\(username.lowercased())"] ?? ""
//                        let usernameDataStr = (usernameData as? String) ?? ""
//                        let emailStr = email ?? ""
//                        if usernameDataStr == emailStr.lowercased() {
//                            print(usernameDataStr)
//                            print("login success")
//                        }
                        self.errorString = "user does not exist"
                        print("user does not exist")
                    }
                }
            } else {
                print("invalid email")
                self.errorString = "email is invalid"
            }
        }
    }
    
}

