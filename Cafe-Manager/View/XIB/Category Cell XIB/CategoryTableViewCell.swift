//
//  CategoryTableViewCell.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-15.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupUI(category:Category){
        nameLabel.text = category.categoryName
    }
}
