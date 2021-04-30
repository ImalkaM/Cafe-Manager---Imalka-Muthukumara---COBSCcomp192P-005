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
    
    var orders:[Order] = []
    var orderedUsers:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        setupCustomUI()
        
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        createSpinnerView()
        if !FieldValidator.isValidEmail(emailField.text ?? ""){
            Loaf("Invalid email address", state: .error, sender: self).show()
            return
        }
        
        
        if !FieldValidator.isValidPassword(pass: passwordField.text ?? "", minLength: 8, maxLength: 20){
            
            Loaf("Invalid password", state: .error, sender: self).show()
            return
            
        }
        
        auhtenticateUser(email: emailField.text!, password: passwordField.text!)
        print(orders)
    }
    func auhtenticateUser(email:String,password:String){
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let err =  error{
                Loaf("\(err.localizedDescription)", state: .error, sender: self).show()
            }
            else{
                if let email = authResult?.user.email{
                    //self.getOrderData()
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
    
    func getOrderedUsers(){
        
        self.ref.child("orders").observe(.value, with: { (snapshot) in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let orderID = child.key
                    self.orderedUsers.append(orderID)
                    
                }
                // print(self.orderedUsers)
                self.getOrders()
            }
        })}
    func getOrders(){
        
        //self.orders.removeAll()
        
        for user in orderedUsers{
            //print(user)
            self.ref.child("orders").child(user)
                .observe(.value) { (snapshot) in
                    if let data = snapshot.value{
                        if let orders = data as? [String:Any]{
                            for singleOrder in orders{
                                if let orderInfo = singleOrder.value as? [String:Any]{
                                    var placedOrder = Order()
                                    placedOrder.orderID = singleOrder.key
                                    placedOrder.custName = user
                                    placedOrder.orderStatus = orderInfo["status"] as! String
                                    if let orderItems = orderInfo["orderItems"] as? [Any]{
                                        for item in orderItems{
                                            if let itemInfo = item as? [String:Any]{
                                                placedOrder.orderTotal += itemInfo["foodPrice"] as! Double
                                            }
                                        }
                                    }
                                    self.orders.append(placedOrder)
                                    
                                }
                                //self.orderTable.reloadData()
                            }
                        }
                    }
                }
        }
        
    }
    
    func setupCustomUI(){
        CustomUI.setupTextField(txtField: emailField)
        CustomUI.setupTextField(txtField: passwordField)
        CustomUI.setupAuthButton(btnCustom: loginButton)
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
}

