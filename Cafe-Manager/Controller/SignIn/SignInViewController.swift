//
//  SignInViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-14.
//

import UIKit
import Loaf
import Firebase

class SignInViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        setupCustomUI()
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        if !FieldValidator.isValidEmail(emailField.text ?? ""){
            Loaf("Invalid email address", state: .error, sender: self).show()
            return
        }
        
        
        if !FieldValidator.isValidPassword(pass: passwordField.text ?? "", minLength: 8, maxLength: 20){
            
            Loaf("Invalid password", state: .error, sender: self).show()
            return
            
        }
        
        auhtenticateUser(email: emailField.text!, password: passwordField.text!)
    }
    func auhtenticateUser(email:String,password:String){
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let err =  error{
                Loaf("\(err.localizedDescription)", state: .error, sender: self).show()
            }
            else{
                if let email = authResult?.user.email{
                    self.getUserData(email: email)
                }else{
                    Loaf("User not found!", state: .error, sender: self).show()
                }
                self.performSegue(withIdentifier: K.loginToHomeSeauge, sender: self)
                
            }
        }
    }
    func getUserData(email:String){
        
        ref.child("users")
            .child(email .replacingOccurrences(of: "@", with: "_")
                    .replacingOccurrences(of: ".", with: "_")).observe(.value, with: {(snapshot) in
                        if snapshot.hasChildren(){
                            if let data = snapshot.value{
                                
                                if let userData = data as? [String:String]{
                                    let user = User(name: userData["userName"]!,
                                                    email: userData["userEmail"]!,
                                                    password: userData["userPassword"]!,
                                                    phonenumber: userData["userPhone"]!)
                                    
                                    
                                    let sessionManager = SessionManager()
                                    sessionManager.saveUserLogin(user: user)
                                }
                            }
                        }else{
                            Loaf("User not found!", state: .error, sender: self).show()
                        }
                    })
    }
    
    func setupCustomUI(){
        CustomUI.setupTextField(txtField: emailField)
        CustomUI.setupTextField(txtField: passwordField)
        CustomUI.setupAuthButton(btnCustom: loginButton)
    }
    
}

