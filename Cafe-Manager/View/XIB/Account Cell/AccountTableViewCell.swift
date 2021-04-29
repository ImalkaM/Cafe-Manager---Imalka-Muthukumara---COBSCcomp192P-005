//
//  AccountTableViewCell.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-28.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellTable: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalSales: UILabel!
    
    @IBOutlet weak var heightcell: NSLayoutConstraint!
    
    var fooodItemsSold = [SoldFoodItems]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellTable.register(UINib(nibName: K.miniTable.accountTableCellDetailsNib, bundle: nil), forCellReuseIdentifier: K.miniTable.accountTableCellDetails)
        cellTable.dataSource = self
            cellTable.delegate = self
        
        
        
        //self.cellTable.estimatedRowHeight = 45
//        self.cellTable.rowHeight = UITableView.automaticDimension
//           self.selectionStyle = .none
//           self.layoutIfNeeded()
//
//           self.cellTable.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        heightcell.constant = 60 * 4
    }
    
    
    func setupView(salesDeatails:SalesDetails){
        
        dateLabel.text = salesDeatails.dateSales
        print(salesDeatails)
        
        fooodItemsSold = salesDeatails.fooodItemsSold
       // print(fooodItemsSold)
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

extension AccountTableViewCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(fooodItemsSold.count)
        return fooodItemsSold.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellTable.dequeueReusableCell(withIdentifier: K.miniTable.accountTableCellDetails, for: indexPath) as! CellTableViewCell
        
        cell.setupView(salesDeatails: fooodItemsSold[indexPath.row])
        print(fooodItemsSold[indexPath.row])
        //cell.setupUI(singleOrderDetails: tempFooditem[indexPath.row])
        cell.layoutSubviews()

          cell.layoutIfNeeded()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}
