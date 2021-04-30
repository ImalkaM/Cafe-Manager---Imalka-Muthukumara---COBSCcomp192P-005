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
        
        guard let text = emailField.text, !text.isEmpty else {
            return signupErrorAlert(title: "Oops!", message: "Don't forget to enter your email!")
        }
        
        if let email = emailField.text{
            
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let err = error{
                    return self.signupErrorAlert(title: "Oops!", message: err.localizedDescription)
                }else{
                    
                }
            }
        }else{
            Loaf("Email cannot be empty", state: .error, sender: self).show()
        }
         
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupCustomUI(){
        CustomUI.setupTextField(txtField: emailField)
       
        CustomUI.setupAuthButton(btnCustom: resetButton)
    }
    
    func signupErrorAlert(title: String, message: String) {
            
            // Called upon signup error to let the user know signup didn't work.
            
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
        present(alert, animated: true, completion: nil)
        }
}
