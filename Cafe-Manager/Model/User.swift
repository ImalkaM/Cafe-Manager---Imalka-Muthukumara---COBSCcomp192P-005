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
    var id:String = ""
    var foodName:String = ""
    var foodDescription:String = ""
    var category:String = ""
    var foodPrice:Double = 0.0
    var discount:Int = 0
    var image:String = ""
    var isAvailable:Bool = false
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
    var orderStatus:String = "NEW"
    var custName:String = ""
    var orderTotal:Double = 0.0
    
    var foodName:String = ""
    var quantity:Int = 0
    var foodPrice:Double = 0.0
    var date:Date = Date()
   
}
struct OrderTest{
    var orderID: String = ""
    var orderStatus:String = "NEW"
    var custName:String = ""
    var orderTotal:Double = 0.0
    var date:Date = Date()
    var foodArray:[FoodItemOrder] = []
   
}

struct FoodItemOrder {
    var foodName:String = ""
    var quantity:Int = 0
    var foodPrice:Double = 0.0
    
    
}


struct CategoryItems {
   let name : String
   var items : [FoodItem]
}
