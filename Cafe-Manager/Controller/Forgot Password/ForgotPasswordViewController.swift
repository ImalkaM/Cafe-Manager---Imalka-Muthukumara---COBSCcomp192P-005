//
//  ForgotPasswordViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-14.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomUI()
    }

    @IBAction func resetTapped(_ sender: UIButton) {
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func setupCustomUI(){
        CustomUI.setupTextField(txtField: emailField)
       
        CustomUI.setupAuthButton(btnCustom: resetButton)
    }
}
