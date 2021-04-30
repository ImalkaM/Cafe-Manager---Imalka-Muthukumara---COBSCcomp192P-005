//
//  SignUpViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-14.
//

import UIKit
import  Firebase
import  Loaf

class SignUpViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        setupCustomUI()
    }
    @IBAction func registerTapped(_ sender: UIButton) {
       
        if let name = nameField.text{
            if name.isEmpty{
                Loaf("Name cannot be empty!", state: .error, sender: self).show()
                return
            }
        }
        
        if !FieldValidator.isValidEmail(EmailField.text ?? ""){
            Loaf("Invalid email address", state: .error, sender: self).show()
            return
        }
        
        
        if !FieldValidator.isValidPassword(pass: passwordField.text ?? "", minLength: 8, maxLength: 20){
            
            Loaf("Invalid password", state: .error, sender: self).show()
            return
            
        }
        if !FieldValidator.isValidMobileNo(phoneField.text ?? ""){
            
            Loaf("Invalid mobile no", state: .error, sender: self).show()
            return
            
        }
        registerUser(email: EmailField.text!, password: passwordField.text!)
    }
  
}

extension SignUpViewController{
    func registerUser(email:String,password:String){
        createSpinnerView()
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err =  error{
                Loaf("\(err.localizedDescription)", state: .error, sender: self).show()
            }
            else{
                let user = User(name: self.nameField.text!, email: self.EmailField.text!, password: self.passwordField.text!, phonenumber: self.phoneField.text!)
                self.createUser(user: user)
            }
        }
    }
    
    func createUser(user:User){
        
        let userData = [
            "userName" : user.name,
            "userEmail" : user.email,
            "userPhone" : user.phonenumber,
            "userPassword" : user.password,
        ]
        self.ref.child("usersCafeManager").child(user.email
                                                    .replacingOccurrences(of: "@", with: "_")
                                                    .replacingOccurrences(of: ".", with: "_")
        ).setValue(userData){ (error, ref) in
            if let err =  error{
                Loaf("\(err.localizedDescription)", state: .error, sender: self).show()
            }
            else{
                Loaf("User Registered successfully", state: .success, sender: self).show()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setupCustomUI(){
        CustomUI.setupTextField(txtField: nameField)
        CustomUI.setupTextField(txtField: EmailField)
        CustomUI.setupTextField(txtField: phoneField)
        CustomUI.setupTextField(txtField: passwordField)
        CustomUI.setupAuthButton(btnCustom: registerButton)
    }
    @IBAction func signInTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func createSpinnerView() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
}
