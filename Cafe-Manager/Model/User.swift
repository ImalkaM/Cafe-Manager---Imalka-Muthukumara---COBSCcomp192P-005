//
//  User.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-11.
//

import Foundation
import Firebase


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
    var isAvailable:Bool
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
}
struct Category{
    var categoryID: String = ""
    var categoryName:String = ""

}

struct Order{
    var orderID: String = ""
    var custName:String = ""
    var foodName:String = ""
    var quantity:Int = 0
    var foodPrice:Double = 0.0
    var orderStatus:String = "NEW"
    var date:Date = Date()
    var orderTotal:Double = 0.0
}
