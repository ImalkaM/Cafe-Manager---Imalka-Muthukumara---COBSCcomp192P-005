//
//  FoodPreviewTableViewCell.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-21.
//

import UIKit
import Kingfisher

class FoodPreviewTableViewCell: UITableViewCell {

  
    @IBOutlet weak var imageFood: UIImageView!
    
    @IBOutlet weak var foodNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var discountContainer: UIView!
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(foodItem:FoodItem){
        foodNameLabel.text = foodItem.foodName
        descriptionLabel.text = foodItem.foodDescription
        priceLabel.text = "RS.\(String(foodItem.foodPrice))"
        imageFood.kf.setImage(with: URL(string: foodItem.image))
        toggleSwitch.isOn = foodItem.isAvailable
        
        if foodItem.discount > 0 {
            discountContainer.isHidden = false
            discountLabel.text =  "\(String(foodItem.discount))%"
        }else{
            discountContainer.isHidden = true
            discountLabel.text = ""
        }
    }
    
}
