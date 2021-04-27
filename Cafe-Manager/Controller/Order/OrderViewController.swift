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
    
    var mobileBrand = [MobileBrand]()
    
    var todayOrdersTest:[OrderTest] = []
    var todayOrdersTestReady:[OrderTest] = []
    
    var categoryize:[OrderItemsCategory] = []
    var date:Double = 0.0
    var datenow:String = ""
    var currentDate:Date = Date()
    
    
    
    @IBOutlet weak var orderTable: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ref = Database.database().reference()
        orderTable.register(UINib(nibName: K.orderTable.nibNameOrderTable, bundle: nil), forCellReuseIdentifier: K.orderTable.orderTableCell)
        //getOrderUsers()
        getOrdersTestNEW()
       // categoryize = [OrderItemsCategory(name: "New", items: todayOrdersTest),OrderItemsCategory(name: "Ready", items: todayOrdersTestReady)]
    }
}

extension OrderViewController: UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryize.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //lbl.text = mobileBrand[section].brandName
        return categoryize[section].items.count
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
        return categoryize[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTable.dequeueReusableCell(withIdentifier: K.orderTable.orderTableCell, for: indexPath) as! OrderTableViewCell
        
        //        let category = categoryWiseFoods[indexPath.section]
        //        let drink = category.items[indexPath.row]
        //
        //cell.setupUI(category: todayOrdersTest[indexPath.row])
        //mobileBrand[indexPath.section].modelName?[indexPath.row]
        cell.setupUI(category: categoryize[indexPath.section].items[indexPath.row])
        
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
                orderDescriptionViewController.setupFoodDescritionView(orderItem: todayOrdersTest[indexPath.row])
            }
        }
        
    }
    
    
}

extension OrderViewController{
    
    func getOrdersTestNEW(){
        //self.todayOrdersTest.removeAll()
        
        
        self.ref.child("orders")
            .observe(.value) { (snapshot) in
                if let categorys = snapshot.value as? [String: Any] {
                    
                    for singlecategory in categorys {
                        // print(singlecategory.key)//email order single
                        
                        if let singleFoodItem = singlecategory.value as? [String: Any] {
                            
                            for item in singleFoodItem{
                                if let orderInfo = item.value as? [String:Any]{
                                    
                                    //  print(item)// single order ids
                                    // print(singleFoodItem.keys)
                                    var placedOrder = OrderTest()
                                    var placedSingleFoodInfo = FoodItemOrder()
                                    placedOrder.orderID = item.key
                                    placedOrder.orderStatus = orderInfo["status"] as! String
                                    placedOrder.custName = orderInfo["customerName"] as! String
                                    print(placedOrder)
                                    if let orderItems = orderInfo["orderItems"] as? [Any]{
                                        for item in orderItems{
                                            
                                            if let itemInfo = item as? [String:Any]{
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
                                    
                                    if self.currentDate.compare(.isToday){
                                        //tempId += 1
                                        self.todayOrdersTest.append(placedOrder)
                                        //print(self.categoryize)
                                        
                                    }
                                }
                                
                                
                                
                            }
                            
                            
                        }
                        print(self.todayOrdersTest)
                        DispatchQueue.main.async {
                            self.orderTable.reloadData()
                        }
                        
                       self.categoryize.append(OrderItemsCategory(name: "NEW", items: self.todayOrdersTest))
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
