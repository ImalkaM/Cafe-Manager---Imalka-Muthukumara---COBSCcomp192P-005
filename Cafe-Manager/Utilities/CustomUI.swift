//
//  CustomUI.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-14.
//

import Foundation
import UIKit

class CustomUI {
    
    static func setupTextField(txtField:UITextField){
        
        txtField.addConstraint(txtField.heightAnchor.constraint(equalToConstant: 50))
        txtField.addConstraint(txtField.widthAnchor.constraint(equalToConstant: 270))
    }
    static func setupAuthButton(btnCustom:UIButton){
        
        btnCustom.layer.cornerRadius = 25
        btnCustom.addConstraint(btnCustom.heightAnchor.constraint(equalToConstant: 50))
    }
    
}
