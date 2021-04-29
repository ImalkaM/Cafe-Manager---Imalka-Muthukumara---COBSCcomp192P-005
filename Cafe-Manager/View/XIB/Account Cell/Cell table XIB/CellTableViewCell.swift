//
//  CellTableViewCell.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-28.
//

import UIKit

class CellTableViewCell: UITableViewCell {
    @IBOutlet weak var itemQTY: UILabel!
    //var fooodItemsSold = [SoldFoodItems]()
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
   
    
    func setupView(salesDeatails:SoldFoodItems){
        
        itemLabel.text = salesDeatails.foodName
        price.text = String( salesDeatails.totalPrice)
//        dateLabel.text = salesDeatails.dateSales
//        print(salesDeatails.dateSales)
//        
//        fooodItemsSold = salesDeatails.fooodItemsSold
//        foodNameLabel.text = foodItem.foodName
//        descriptionLabel.text = foodItem.foodDescription
//        priceLabel.text = "RSs.\(String(foodItem.foodPrice))"
//        imageFood.kf.setImage(with: URL(string: foodItem.image))
//        //toggleSwitch.isOn = foodItem.isAvailable
//        tempAvialable = foodItem.isAvailable
//
//        if foodItem.discount > 0 {
//            discountContainer.isHidden = false
//            discountLabel.text =  "\(String(foodItem.discount))%"
//        }else{
//            discountContainer.isHidden = true
//            discountLabel.text = ""
//        }
//        foodItemTemp.id = foodItem.id
//        foodItemTemp.category = categoryName
        
    }
}
