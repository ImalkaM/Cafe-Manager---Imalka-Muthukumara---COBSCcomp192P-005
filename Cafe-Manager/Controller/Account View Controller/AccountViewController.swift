//
//  AccountViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-28.
//

import UIKit
import Firebase
import SwiftDate

class AccountViewController: UIViewController{
    
    var ref: DatabaseReference!
    @IBOutlet weak var fromDateField: UITextField!
    @IBOutlet weak var toDateField: UITextField!
    
    @IBOutlet weak var accountTable: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    let datePicker = UIDatePicker()
    
    var currentDate:Date = Date()
    //var tempFooditem =  [SoldFoodItems]()
    var fooodItemsSold = [SoldFoodItems]()
    var allSales =  [SalesDetails]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        accountTable.register(UINib(nibName: K.accountCell.nibNameAccountDetailsTable, bundle: nil), forCellReuseIdentifier: K.accountCell.accountTableCell)
        self.accountTable.rowHeight = UITableView.automaticDimension
            self.accountTable.estimatedRowHeight = 45
        
        createDatePickerFrom(textfield: fromDateField)
        createDatePickerTo(textfield: toDateField)
        
        getSoldItemData()
    }
  
}
extension AccountViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = accountTable.dequeueReusableCell(withIdentifier: K.accountCell.accountTableCell, for: indexPath) as! AccountTableViewCell
        
        cell.setupView(salesDeatails: allSales[indexPath.row])
        
        //cell.setupUI(singleOrderDetails: tempFooditem[indexPath.row])
        cell.layoutSubviews()

          cell.layoutIfNeeded()
        return cell
    }
    
    
}

extension AccountViewController{
    
    func getSoldItemData(){
        
        self.ref.child("sales")
            .observeSingleEvent(of: .value) { (snapshot) in
                if let categorys = snapshot.value as? [String: Any] {
                    
                   // print()//dates
                    
                    for singlecategory in categorys {
                        if let singleFoodItem = singlecategory.value as? [String: Any] {
                            var singleSales = SoldFoodItems()
                           
                            for singleItem in singleFoodItem{
                                
                                singleSales.foodName = singleItem.key
                                singleSales.totalPrice = singleItem.value as! Double
                                
                                self.fooodItemsSold.append(singleSales)
                                print(singleSales.foodName)
                            }
                            self.allSales.append(SalesDetails(dateSales: singlecategory.key, fooodItemsSold: self.fooodItemsSold))
                            print(self.allSales)
                            DispatchQueue.main.async {
                                self.accountTable.reloadData()
                            }
//                            singleSales.foodName = singleFoodItem
//                            placedOrder.orderTotal += itemInfo["foodPrice"] as! Double
//                            placedSingleFoodInfo.quantity = itemInfo["qunatity"] as! Int
                            
                            
                           // print(singleFoodItem)
                        }
                       // print(singlecategory.value)
                        
                    }
                }
            }
//        var placedOrder = SingleOrderDetails()
//        var placedSingleFoodInfo = FoodItemOrder()
//        placedOrder.orderID = item.key
//        placedOrder.orderStatus = orderInfo["status"] as! String
//        placedOrder.custName = orderInfo["customerName"] as! String
//        print(placedOrder)
//        if let orderItems = orderInfo["orderItems"] as? [Any]{
//            for item in orderItems{
//
//                if let itemInfo = item as? [String:Any]{
//                    placedOrder.custEmail = singlecategory.key
//                    placedOrder.orderTotal += itemInfo["foodPrice"] as! Double
//                    placedSingleFoodInfo.quantity = itemInfo["qunatity"] as! Int
//                    placedSingleFoodInfo.foodName = itemInfo["foodName"] as! String
//                    placedSingleFoodInfo.foodPrice = itemInfo["foodPrice"] as! Double
        
//        self.ref.child("orders")
//            .observe(.value) { (snapshot) in
//                if let categorys = snapshot.value as? [String: Any] {
//                    self.categoryize = []
//                    self.todayOrdersTest = []
//                    self.orderCategoryArray[0].items = []
//                    self.orderCategoryArray[1].items = []
//                    for singlecategory in categorys {
//                        // print(singlecategory.key)//email order single
//
//                        if let singleFoodItem = singlecategory.value as? [String: Any] {
//
//                            for item in singleFoodItem{
//                                if let orderInfo = item.value as? [String:Any]{
    }
}

extension AccountViewController{
    
    func createDatePickerFrom(textfield:UITextField){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let donBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolBar.setItems([donBtn], animated: true)
        
        textfield.inputAccessoryView = toolBar
        
        textfield.inputView = datePicker
        
        
        datePicker.datePickerMode = .date
    }
    
    @objc func donePressed(){
        
        fromDateField.text = datePicker.date.toFormat("dd-MM-yyyy")
        self.view.endEditing(true)
    }
    
    func createDatePickerTo(textfield:UITextField){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let donBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedTo))
        
        toolBar.setItems([donBtn], animated: true)
        
        textfield.inputAccessoryView = toolBar
        
        textfield.inputView = datePicker
        
        
        datePicker.datePickerMode = .date
    }
    
    @objc func donePressedTo(){
        
        toDateField.text = datePicker.date.toFormat("dd-MM-yyyy")
        self.view.endEditing(true)
    }
}
