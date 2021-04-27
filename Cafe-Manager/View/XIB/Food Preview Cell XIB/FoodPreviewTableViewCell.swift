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
    
    var tempAvialable:Bool = false
    
    var delegate: foodAvailableDelegate!
    var indexPath: IndexPath!
    
    var foodItemTemp:FoodItem = FoodItem()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        toggleSwitch.isOn = tempAvialable
        // Configure the view for the selected state
    }
    
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        tempAvialable.toggle()
        delegate.availableButtonToggled(at: indexPath, isOn: tempAvialable, foodItem: foodItemTemp)
    }
    
    
    func setupView(foodItem:FoodItem, categoryName:String){
        foodNameLabel.text = foodItem.foodName
        descriptionLabel.text = foodItem.foodDescription
        priceLabel.text = "RSs.\(String(foodItem.foodPrice))"
        imageFood.kf.setImage(with: URL(string: foodItem.image))
        //toggleSwitch.isOn = foodItem.isAvailable
        tempAvialable = foodItem.isAvailable
        
        if foodItem.discount > 0 {
            discountContainer.isHidden = false
            discountLabel.text =  "\(String(foodItem.discount))%"
        }else{
            discountContainer.isHidden = true
            discountLabel.text = ""
        }
        foodItemTemp.id = foodItem.id
        foodItemTemp.category = categoryName
        
    }
    
    
    
}

protocol foodAvailableDelegate {
    func availableButtonToggled(at indexPath: IndexPath,isOn:Bool,foodItem:FoodItem)
}
