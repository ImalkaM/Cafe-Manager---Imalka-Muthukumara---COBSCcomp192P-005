//
//  OrderViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-24.
//

import UIKit
import Firebase
import Loaf
import SwiftDate

class OrderViewController: UIViewController {
    
    var ref: DatabaseReference!
    var todayOrders:[Order] = []
    var allOrders:[Order] = []
    var orderUsers:[String] = []
    
   // var mobileBrand = [MobileBrand]()
    
    var todayOrdersTest:[SingleOrderDetails] = []
    var todayOrdersReady:[SingleOrderDetails] = []
    
   var orderCategoryArray = [OrderItemsCategory]()
    
    var titles:[String] = ["Neww","Ready"]
    
    var categoryize:[OrderItemsCategory] = []
    var date:Double = 0.0
    var datenow:String = ""
    var currentDate:Date = Date()
    
    
    
    @IBOutlet weak var orderTable: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        orderCategoryArray = [OrderItemsCategory(name: "New", items: todayOrdersTest),
                              OrderItemsCategory(name: "Ready", items: todayOrdersReady)
        ]
        ref = Database.database().reference()
        orderTable.register(UINib(nibName: K.orderTable.nibNameOrderTable, bundle: nil), forCellReuseIdentifier: K.orderTable.orderTableCell)
        //getOrderUsers()
        getAllOrders()
        
        
        
       // categoryize = [OrderItemsCategory(name: "New", items: todayOrdersTest),OrderItemsCategory(name: "Ready", items: todayOrdersTestReady)]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.orderTable.reloadData()
        }
    }
    
    @IBAction func unwindFromOrderDetails( _ seg: UIStoryboardSegue) {
    }
}
extension OrderViewController: orderItemDelegate {
    
    func rejectButtonTapped(at indexPath: IndexPath, tempItemDetails: SingleOrderDetails) {
        //print("Tappedr \(self.categoryize[indexPath.section].items[indexPath.row].custEmail)")
        
       
       
        self.orderCategoryArray[0].items.remove(at: indexPath.row)
      
       self.orderTable.deleteRows(at: [indexPath], with: .fade)
        ref.child("orders")
            .child(tempItemDetails.custEmail)
            .child(tempItemDetails.orderID)
            .child("status")
            .setValue(OrderStatus.cancel.rawValue){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                //error
            } else {

                DispatchQueue.main.async {
                    self.orderTable.reloadData()
                }
                //self.getFoodItems()
                //self.foodItemArray.remove(at: indexPath.row)
            }
        }
    }
    
    func acceptButtontapped(at indexPath: IndexPath, tempItemDetails: SingleOrderDetails) {
        print("Tappeda \(indexPath.row)")
       
        self.orderCategoryArray[0].items.remove(at: indexPath.row)
      
        self.orderTable.deleteRows(at: [indexPath], with: .fade)
        
        //orderCategoryArray[1].items.append(tempItemDetails)
 
         ref.child("orders")
             .child(tempItemDetails.custEmail)
             .child(tempItemDetails.orderID)
             .child("status")
             .setValue(OrderStatus.Preapration.rawValue){
             (error:Error?, ref:DatabaseReference) in
             if let error = error {
                 //error
             } else {

                 DispatchQueue.main.async {
                     self.orderTable.reloadData()
                 }
                 //self.getFoodItems()
                 //self.foodItemArray.remove(at: indexPath.row)
             }
         }
       
//        if categoryize[1].name.isEmpty{
//            self.categoryize[1].items.append(<#T##newElement: OrderTest##OrderTest#>)
//        }

        
        DispatchQueue.main.async {
            self.orderTable.reloadData()
        }
        
    }
    
}

extension OrderViewController: UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderCategoryArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //lbl.text = mobileBrand[section].brandName
        
        print(orderCategoryArray[section].items.count)
        return orderCategoryArray[section].items.count
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
//        view.backgroundColor = #colorLiteral(red: 1, green: 0.3653766513, blue: 0.1507387459, alpha: 1)
//
//        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
//        lbl.font = UIFont.systemFont(ofSize: 20)
//        lbl.text = categoryize[section].name
//        view.addSubview(lbl)
//        return view
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return categoryize[section].name
        return orderCategoryArray[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTable.dequeueReusableCell(withIdentifier: K.orderTable.orderTableCell, for: indexPath) as! OrderTableViewCell
        
        //        let category = categoryWiseFoods[indexPath.section]
        //        let drink = category.items[indexPath.row]
        //
        //cell.setupUI(category: todayOrdersTest[indexPath.row])
        cell.setupUI(category: orderCategoryArray[indexPath.section].items[indexPath.row])
        print(orderCategoryArray[indexPath.section].items[indexPath.row])
        //mobileBrand[indexPath.section].modelName?[indexPath.row]
        cell.indexPath = indexPath
        cell.delegate = self
        //cell.setupUI(category: categoryize[indexPath.section].items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == orderTable{
            performSegue(withIdentifier: K.OrderTableToOrderDetailsSeauge, sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == K.OrderTableToOrderDetailsSeauge{
            if let indexPath = orderTable.indexPathForSelectedRow {
                let orderDescriptionViewController = segue.destination as! OrderDetailsViewController
                //orderDescriptionViewController.setupFoodDescritionView(orderItem: todayOrdersTest[indexPath.row])
                orderDescriptionViewController.setupFoodDescritionView(orderItem: orderCategoryArray[indexPath.section].items[indexPath.row])
            }
        }
        
    }
    
}

extension OrderViewController{
    
    func getAllOrders(){
        //self.todayOrdersTest.removeAll()
        
        
        self.ref.child("orders")
            .observe(.value) { (snapshot) in
                if let categorys = snapshot.value as? [String: Any] {
                    self.categoryize = []
                    self.todayOrdersTest = []
                    self.orderCategoryArray[0].items = []
                    self.orderCategoryArray[1].items = []
                    for singlecategory in categorys {
                        // print(singlecategory.key)//email order single
                        
                        if let singleFoodItem = singlecategory.value as? [String: Any] {
                            
                            for item in singleFoodItem{
                                if let orderInfo = item.value as? [String:Any]{
                                    
                                    //  print(item)// single order ids
                                    // print(singleFoodItem.keys)
                                    var placedOrder = SingleOrderDetails()
                                    var placedSingleFoodInfo = FoodItemOrder()
                                    placedOrder.orderID = item.key
                                    placedOrder.orderStatus = orderInfo["status"] as! String
                                    placedOrder.custName = orderInfo["customerName"] as! String
                                    print(placedOrder)
                                    if let orderItems = orderInfo["orderItems"] as? [Any]{
                                        for item in orderItems{
                                            
                                            if let itemInfo = item as? [String:Any]{
                                                placedOrder.custEmail = singlecategory.key
                                                placedOrder.orderTotal += itemInfo["foodPrice"] as! Double
                                                placedSingleFoodInfo.quantity = itemInfo["qunatity"] as! Int
                                                placedSingleFoodInfo.foodName = itemInfo["foodName"] as! String
                                                placedSingleFoodInfo.foodPrice = itemInfo["foodPrice"] as! Double
                                                self.date = itemInfo["timestamp"] as! Double
                                                self.datenow = self.convertTimestampToString(serverTimestamp: self.date)
                                                self.currentDate = self.convertTimestampToDate(serverTimestamp: self.datenow)
                                                placedOrder.date = self.currentDate
                                                placedOrder.foodArray.append(placedSingleFoodInfo)
                                                print(placedOrder.foodArray)
                                            }
                                        }
                                    }
                                    
                                    if self.currentDate.compare(.isToday) &&   placedOrder.orderStatus != OrderStatus.cancel.rawValue{
                                        //tempId += 1
                                        //self.todayOrdersTest.append(placedOrder)
                                        if placedOrder.orderStatus == OrderStatus.ready.rawValue {
                                            
                                            self.orderCategoryArray[1].items.append(placedOrder)
                                        }else{
                                            self.orderCategoryArray[0].items.append(placedOrder)
                                        }
                                  
                                        
                                    }
                                }
                                
                            }
                            
                        }
                        print(self.todayOrdersTest)
                        DispatchQueue.main.async {
                            self.orderTable.reloadData()
                        }
                        
                        //self.categoryize.append(OrderItemsCategory(items: self.todayOrdersTest))
                        //self.categoryize.append(OrderItemsCategory(name: "NEW", items: self.todayOrdersTest))
                        //print(self.categoryize)
                    }
                    
                }
                
            }}
    
    
    func convertTimestampToString(serverTimestamp: Double) -> String {
        let x = serverTimestamp / 1000
        let date = NSDate(timeIntervalSince1970: x)
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        
        
        return formatter.string(from: date as Date)
    }
    
    func convertTimestampToDate(serverTimestamp: String) -> Date {
        
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        
        
        return formatter.date(from: serverTimestamp as String) ?? Date()
    }
}
