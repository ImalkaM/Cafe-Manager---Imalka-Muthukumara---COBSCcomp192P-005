//
//  OrderTableViewCell.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-24.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cusNameLabel: UILabel!
    @IBOutlet weak var orderIdLabel: UILabel!
    
    
    @IBOutlet weak var rejectButtoncobtainer: UIView!
    
    @IBOutlet weak var acceptButonContainer: UIView!
    @IBOutlet weak var rejectButton: UIButton!
    
    var delegate: orderItemDelegate!
    var indexPath: IndexPath!
    
    var tempItemDetails:SingleOrderDetails = SingleOrderDetails(orderID: "", orderStatus: "", custName: "", custEmail: "", orderTotal: 213, date: Date(), foodArray: [FoodItemOrder(foodName: "", quantity: 1, foodPrice: 12.2)])
    
    @IBOutlet weak var acceptButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func rejectButtonTapped(_ sender: UIButton) {
        
        delegate.rejectButtonTapped(at: indexPath, tempItemDetails: tempItemDetails)
        
    }
    
    
    @IBAction func acceptButtonTapped(_ sender: UIButton) {
        
        delegate.acceptButtontapped(at: indexPath, tempItemDetails: tempItemDetails)
    }
    
    
    
    func setupUI(category:SingleOrderDetails){
        tempItemDetails = category
        cusNameLabel.text = category.custName
        orderIdLabel.text = category.orderID
        if  category.orderStatus == OrderStatus.Preapration.rawValue{
            rejectButtoncobtainer.isHidden = true
            acceptButonContainer.backgroundColor = UIColor.green
            acceptButton.setTitleColor(.black, for: .normal)
            acceptButton.setTitle("Accepted", for: .normal)
        }else if  category.orderStatus == "Pending"{
            acceptButonContainer.backgroundColor = UIColor.green
            rejectButtoncobtainer.backgroundColor = UIColor.red
            acceptButton.setTitleColor(.black, for: .normal)
            acceptButton.setTitle("Accept", for: .normal)
            rejectButton.setTitleColor(.black, for: .normal)
            rejectButton.setTitle("Reject", for: .normal)
            rejectButtoncobtainer.isHidden = false
        }else{
            
            rejectButtoncobtainer.isHidden = false
        }
        
    }
}

protocol orderItemDelegate {
    func rejectButtonTapped(at indexPath: IndexPath,tempItemDetails:SingleOrderDetails)
    func acceptButtontapped(at indexPath: IndexPath,tempItemDetails:SingleOrderDetails)
}
