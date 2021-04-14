//
//  SignUpViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-14.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomUI()
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupCustomUI(){
        CustomUI.setupTextField(txtField: nameField)
        CustomUI.setupTextField(txtField: EmailField)
        CustomUI.setupTextField(txtField: phoneField)
        CustomUI.setupTextField(txtField: passwordField)
        CustomUI.setupAuthButton(btnCustom: registerButton)
    }
    
}
