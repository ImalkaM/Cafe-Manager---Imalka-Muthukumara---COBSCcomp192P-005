//
//  CartHandler.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-13.
//

import Foundation
import Firebase


class CartHandler{
    static var fooditem:[CartItem] = []
    
    static func getCartItems() -> [CartItem]{
        return fooditem
    }
    
    static func clearCart(){
        self.fooditem.removeAll()
    }
}

class StoreHandler{
    static var categoryCollection:[Category] = []
    static var categoryWiseFoods:[CategoryItems] = []
    static var category:Category = Category(categoryID: "", categoryName: "")
    static var foodItemArray:[FoodItem] = []
    
    static func getCartItems() -> [Category]{
        return categoryCollection
    }
    
    static func clearCart(){
        self.categoryCollection.removeAll()
    }
    
    static func getCategorys(ref:DatabaseReference!){
    
            ref.child("category").observe(.value) { (snapshot) in
                if let data = snapshot.value{
                    categoryCollection = []
                    if let orders = data as? [String:Any]{
                       StoreHandler.categoryCollection.removeAll()
                        for singleCategory in orders{
                            if let categoryInfo = singleCategory.value as? [String:Any]{
                                category.categoryName = categoryInfo["categoryName"] as! String
                                category.categoryID = singleCategory.key
                                StoreHandler.categoryCollection.append(category)
                            }
                        }
                       // self.categoryTable.reloadData()
                    }
                }
            }
        }
    
   static func getFoodItems(ref:DatabaseReference!){
        
        StoreHandler.categoryWiseFoods = []
        
        for categorys in StoreHandler.categoryCollection{
            
            ref.child("FoodItemsCafe").child(categorys.categoryName)
                .observeSingleEvent(of:.value) { (snapshot) in
                    print(categorys.categoryName)
                    StoreHandler.foodItemArray = []
                    
                    if let data = snapshot.value {
                        
                        if let foodItems = data as? [String:Any]{
                            // print(foodItems.keys)
                            for singleItem in foodItems{
                                //print(singleItem)
                                if let itemInfo = singleItem.value as? [String:Any]{
                                    var foodItems = FoodItem()
                                    foodItems.id = singleItem.key
                                    foodItems.foodName = itemInfo["foodName"] as! String
                                    foodItems.foodDescription = itemInfo["foodDescription"] as! String
                                    foodItems.foodPrice = itemInfo["price"] as! Double
                                    foodItems.discount = itemInfo["discount"] as! Int
                                    foodItems.isAvailable = itemInfo["available"] as! Bool
                                    foodItems.image = itemInfo["imageURL"] as! String
                                    
                                    
                                    StoreHandler.foodItemArray.append(foodItems)
                                    
                                }
                                
                            }
                            StoreHandler.categoryWiseFoods.append(CategoryItems(name: categorys.categoryName, items: StoreHandler.foodItemArray))
                            
                        }
                    }
                }
            
        }
        
        
    }
        
}
