//
//  OrderDetailsViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-24.
//

import UIKit

class OrderDetailsViewController: UIViewController {

    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cusNameOrderIDlabel: UILabel!
   
    @IBOutlet weak var orderDetailsTable: UITableView!
    
    var orderDescriptionItem:Order = Order(orderID: "", orderStatus: "", custName: "", orderTotal: 0.0, foodName: "", quantity: 0, foodPrice: 0.0, date: Date() )
    
    
    var tempFooditem:[FoodItemOrder] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderDetailsTable.register(UINib(nibName: K.orderDetailsTable.nibNameOrderDetailsTable, bundle: nil), forCellReuseIdentifier: K.orderDetailsTable.orderDetailsTableCell)
        statusLabel.text = orderDescriptionItem.orderStatus
        cusNameOrderIDlabel.text = ("\(String(orderDescriptionItem.custName))(\(orderDescriptionItem.orderID))")
        
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
        print(tempFooditem)

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
