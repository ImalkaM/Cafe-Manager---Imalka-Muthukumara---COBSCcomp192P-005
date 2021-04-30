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
struct SingleOrderDetails{
    var orderID: String = ""
    var orderStatus:String = "NEW"
    var custName:String = ""
    var custEmail:String = ""
    var orderTotal:Double = 0.0
    var date:Date = Date()
    var foodArray:[FoodItemOrder] = []
   
}

struct FoodItemOrder {
    var foodName:String = ""
    var quantity:Int = 0
    var foodPrice:Double = 0.0
   
}

struct OrderItemsCategory {
   var name : String!
   var items : [SingleOrderDetails]!
}

struct SalesDetails {
    var dateSales:String = ""
    var totalPriceAll:Double = 0.0
    var fooodItemsSold = [SoldFoodItems]()
}

struct SoldFoodItems {
    var foodName:String = ""
    var totalPrice:Double = 0.0 
}


struct CategoryItems {
    
   let name : String
   var items : [FoodItem]
}
