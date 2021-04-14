//
//  SessionManager.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-11.
//

import Foundation


class SessionManager {
    
    let userDeafualts = UserDefaults()
    
    func saveUserLogin(user: User){
        
        UserDefaults.standard.setValue(true, forKey: "Logged_IN")
        UserDefaults.standard.setValue(user.name, forKey: "USER_NAME")
        UserDefaults.standard.setValue(user.email, forKey: "USER_EMAIL")
        UserDefaults.standard.setValue(user.phonenumber, forKey: "USER_PHONE")
    }
    
    func getUserData() -> User{
        
        let user = User(name: UserDefaults.standard.string(forKey: "USER_NAME") ?? "",
                        email: UserDefaults.standard.string(forKey: "USER_EMAIL") ?? "",
                        password: UserDefaults.standard.string(forKey: "") ?? "",
                        phonenumber: UserDefaults.standard.string(forKey: "USER_PHONE") ?? "")
        return user
    }
    
    func clearUserState(){
        
        UserDefaults.standard.setValue(false, forKey: "Logged_IN")
    }
    
    func getUserLoggedState()->Bool{
        
        return  UserDefaults.standard.bool(forKey: "Logged_IN")
         
    }
}
