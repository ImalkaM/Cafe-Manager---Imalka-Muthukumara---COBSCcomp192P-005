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
        
    }
    
    
    @IBAction func acceptButtonTapped(_ sender: UIButton) {
        
    }
    
    
    
    func setupUI(category:OrderTest){
        cusNameLabel.text = category.custName
        orderIdLabel.text = category.orderID
        
        if  category.orderStatus == "Arriving"{
            rejectButtoncobtainer.isHidden = true
            acceptButonContainer.backgroundColor = UIColor.yellow
            acceptButton.setTitleColor(.black, for: .normal)
            acceptButton.setTitle("Arriving", for: .normal)
        }
        

    }
}
