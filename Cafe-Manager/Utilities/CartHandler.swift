//
//  CartHandler.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-13.
//

import Foundation


class CartHandler{
    static var fooditem:[CartItem] = []
    
    static func getCartItems() -> [CartItem]{
        return fooditem
    }
    
    static func clearCart(){
        self.fooditem.removeAll()
    }
}
