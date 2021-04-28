//
//  OrderDetailsTableViewCell.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-25.
//

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setupUI(singleOrderDetails:FoodItemOrder){
        foodNameLabel.text = singleOrderDetails.foodName
        priceLabel.text = String(singleOrderDetails.foodPrice)
        qtyLabel.text = ("\(String(singleOrderDetails.quantity)) x")
        
    }
    
    
    
}


