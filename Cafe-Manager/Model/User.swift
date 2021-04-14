//
//  User.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-11.
//

import Foundation


struct User {
    var name:String
    var email:String
    var password:String
    var phonenumber:String
}

struct FoodItem {
    var id:String
    var foodName:String
    var foodDescription:String
    var category:String
    var foodPrice:Double
    var discount:Int
    var image:String
}

struct CartItem {
    var itemName: String = ""
    var itemImgRes: String = ""
    var discount: Int = 0
    var itemPrice: Double = 0
    var itemCount: Int = 0
    var itemTotal: Double {
        return Double(itemCount) *  itemPrice
    }
    

//    var discountedPrice: Double {
//        return itemPrice - (itemPrice * (Double(discount)/100))
//    }
}

struct Order {
    var orderID: String = ""
    var orderStatus:String = ""
    var orderTotal:Double = 0.0
}
