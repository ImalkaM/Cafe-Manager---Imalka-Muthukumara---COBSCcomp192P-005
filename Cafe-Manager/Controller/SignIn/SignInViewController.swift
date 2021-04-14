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
        
        setupCustomUI()
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
    }
    
    func setupCustomUI(){
        CustomUI.setupTextField(txtField: emailField)
        CustomUI.setupTextField(txtField: passwordField)
        CustomUI.setupAuthButton(btnCustom: loginButton)
    }
}
