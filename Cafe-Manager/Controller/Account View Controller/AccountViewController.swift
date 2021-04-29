//
//  AccountViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-28.
//

import UIKit

class AccountViewController: UIViewController {
    
    
    @IBOutlet weak var accountTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accountTable.register(UINib(nibName: K.accountCell.nibNameAccountDetailsTable, bundle: nil), forCellReuseIdentifier: K.accountCell.accountTableCell)
        self.accountTable.rowHeight = UITableView.automaticDimension
            self.accountTable.estimatedRowHeight = 45
    }
    


}
extension AccountViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = accountTable.dequeueReusableCell(withIdentifier: K.accountCell.accountTableCell, for: indexPath) as! AccountTableViewCell
        
        //cell.setupUI(singleOrderDetails: tempFooditem[indexPath.row])
        cell.layoutSubviews()

          cell.layoutIfNeeded()
        return cell
    }
    
    
    
    
    
}
