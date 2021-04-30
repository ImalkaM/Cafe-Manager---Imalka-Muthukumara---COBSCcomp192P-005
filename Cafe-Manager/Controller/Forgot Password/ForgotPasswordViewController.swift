//
//  ForgotPasswordViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-14.
//

import UIKit
import FirebaseAuth
import Firebase
import Loaf

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomUI()
    }

    @IBAction func resetTapped(_ sender: UIButton) {
        
        if let email = emailField.text{
            
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let err = error{
                    
                }else{
                    
                }
            }
        }
         
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupCustomUI(){
        CustomUI.setupTextField(txtField: emailField)
       
        CustomUI.setupAuthButton(btnCustom: resetButton)
    }
}
