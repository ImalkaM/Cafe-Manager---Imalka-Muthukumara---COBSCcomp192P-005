//
//  OrderDetailsViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-24.
//

import UIKit
import Firebase
import SwiftDate
import Loaf

class OrderDetailsViewController: UIViewController {

    var ref: DatabaseReference!
    @IBOutlet weak var cusNameOrderIDlabel: UILabel!
   
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var statusContainer: UIView!
    @IBOutlet weak var orderDetailsTable: UITableView!
    
    var currentDate:Date = Date()
    
    var orderDescriptionItem:Order = Order(orderID: "", orderStatus: "", custName: "", orderTotal: 0.0, foodName: "", quantity: 0, foodPrice: 0.0, date: Date() )
    
    
    var tempFooditem:[FoodItemOrder] = []
    var tempFooditemFB:[FoodItemOrder] = []
    
    var placedOrder = SingleOrderDetails()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        orderDetailsTable.register(UINib(nibName: K.orderDetailsTable.nibNameOrderDetailsTable, bundle: nil), forCellReuseIdentifier: K.orderDetailsTable.orderDetailsTableCell)
        statusButton.setTitle(orderDescriptionItem.orderStatus, for: .normal)
        cusNameOrderIDlabel.text = ("\(String(orderDescriptionItem.custName))(\(orderDescriptionItem.orderID))")
        
        if orderDescriptionItem.orderStatus == OrderStatus.Preapration.rawValue{
            
            statusContainer.backgroundColor = UIColor.green
            statusButton.setTitle("Finish", for: .normal)
            statusButton.setTitleColor(.black, for: .normal)
        }else{
            
            statusContainer.backgroundColor = UIColor.gray
            statusButton.setTitle("Pending", for: .normal)
            statusButton.setTitleColor(.black, for: .normal)
            statusButton.isEnabled = false
        }
        tempFooditemFB = tempFooditem
        print(tempFooditemFB)
        ggnew()
    }
    
    @IBAction func statusButtonTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: K.orderDetailsTable.unwindSeauge, sender: self)
        
        ref.child("orders")
            .child(placedOrder.custEmail)
            .child(placedOrder.orderID)
            .child("status")
            .setValue(OrderStatus.ready.rawValue){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                //error
            } else {
                self.gg1()
               // self.gg()
                //self.getFoodItems()
                //self.foodItemArray.remove(at: indexPath.row)
            }
                
        }
           
    }
    
    func gg(){
        
        for item in tempFooditem{
//                let userData = [
//                    "\(item.foodName)" : item.foodPrice
//                ]
           
            ref.child("sales").child("\(currentDate.toFormat("dd_MM_yyyy"))")
                .child("\(item.foodName)")
                .observeSingleEvent(of:.value, with: { (snapshot) in
              // Get user value
                    print(self.currentDate.toFormat("dd_MM_yyyy"))
                    if let categorys = snapshot.value as?  Double {
                        print(categorys)
                        self.ref.child("sales/\(self.currentDate.toFormat("dd_MM_yyyy"))/\(item.foodName)").setValue(item.foodPrice + categorys){ (error, ref) in
                            if let err =  error{
                                Loaf("\(err.localizedDescription)", state: .error, sender: self).show()
                            }
                            else{
                                //                        Loaf("User Registered successfully", state: .success, sender: self).show()
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                                     
                        
                       // print(categorys)
                    }
                    
                   
             //let user = User(username: username)
//
              }) { (error) in
                print(error.localizedDescription)
            }
            //self.ref.child("users/\(user.uid)/username").setValue(username)

        }
        
//        self.ref.child("orders")
//            .observe(.value) { (snapshot) in
//                if let categorys = snapshot.value as? [String: Any] {
//                    self.categoryize = []
//                    self.todayOrdersTest = []
//                    self.orderCategoryArray[0].items = []
//                    self.orderCategoryArray[1].items = []
//                    for singlecategory in categorys {
    }
    
    
    func ggnew(){
        
        ref.child("sales").child("\(currentDate.toFormat("dd_MM_yyyy"))")
            .observeSingleEvent(of:.value, with: { (snapshot) in
                print(self.currentDate.toFormat("dd_MM_yyyy"))
                if let categorys = snapshot.value as? [String: Any] {
                    
                    
                    print(categorys.keys)
                                 
                    
                   // print(categorys)
                }
                
               
         //let user = User(username: username)
//
          }) { (error) in
            print(error.localizedDescription)
        }

    }
    func gg1(){
        
        for item in tempFooditem{
                let userData = [
                    "\(item.foodName)" : item.foodPrice
                ]
            //var tfg = "2010-05-20"
            print(currentDate.toFormat("yyyy_MM_dd"))
            ref.child("sales").child("\(currentDate.toFormat("yyyy_MM_dd"))")
                .child(item.foodName)
                .updateChildValues(userData)
            
            //gg()
              // Get user value
            
                   
             //let user = User(username: username)
//
            //self.ref.child("users/\(user.uid)/username").setValue(username)

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? OrderViewController {
            
        }
    }
    
    
    @IBAction func callButtonTapped(_ sender: UIButton) {
    }
    @IBAction func backButtontapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupFoodDescritionView(orderItem:SingleOrderDetails){
        orderDescriptionItem.custName = orderItem.custName
        orderDescriptionItem.orderID = orderItem.orderID
        orderDescriptionItem.orderStatus = orderItem.orderStatus
        
        tempFooditem.append(contentsOf: orderItem.foodArray)
        
        placedOrder = orderItem
        print(placedOrder)
    }
    
}

extension OrderDetailsViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tempFooditem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderDetailsTable.dequeueReusableCell(withIdentifier: K.orderDetailsTable.orderDetailsTableCell, for: indexPath) as! OrderDetailsTableViewCell
        
        cell.setupUI(singleOrderDetails: tempFooditem[indexPath.row])
        
        return cell
    }
   
}
