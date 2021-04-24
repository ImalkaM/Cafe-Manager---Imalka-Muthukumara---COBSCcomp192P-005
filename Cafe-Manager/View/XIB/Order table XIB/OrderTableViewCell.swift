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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupUI(category:Order){
        cusNameLabel.text = category.custName
        orderIdLabel.text = category.orderID
    }
}
