//
//  SignInViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-14.
//

import UIKit

class SignInViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTextFieldSizeSetup()
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
    }
    
    func registerTextFieldSizeSetup(){
        emailField.addConstraint(emailField.heightAnchor.constraint(equalToConstant: 50))
        emailField.addConstraint(emailField.widthAnchor.constraint(equalToConstant: 270))
        
        passwordField.addConstraint(passwordField.heightAnchor.constraint(equalToConstant: 50))
        passwordField.addConstraint(passwordField.widthAnchor.constraint(equalToConstant: 270))
        
        
        loginButton.layer.cornerRadius = 25
        loginButton.addConstraint(loginButton.heightAnchor.constraint(equalToConstant: 50))
        
    }
}
