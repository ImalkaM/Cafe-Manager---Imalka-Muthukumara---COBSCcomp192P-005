//
//  OrderDetailsViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-24.
//

import UIKit
import Firebase

class OrderDetailsViewController: UIViewController {

    var ref: DatabaseReference!
    @IBOutlet weak var cusNameOrderIDlabel: UILabel!
   
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var statusContainer: UIView!
    @IBOutlet weak var orderDetailsTable: UITableView!
    
    var orderDescriptionItem:Order = Order(orderID: "", orderStatus: "", custName: "", orderTotal: 0.0, foodName: "", quantity: 0, foodPrice: 0.0, date: Date() )
    
    
    var tempFooditem:[FoodItemOrder] = []
    
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

                //self.getFoodItems()
                //self.foodItemArray.remove(at: indexPath.row)
            }
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
