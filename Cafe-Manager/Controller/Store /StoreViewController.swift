//
//  StoreViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-14.
//

import UIKit

class StoreViewController: UIViewController {
    
    
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var categoryBtn: UIButton!
    
    @IBOutlet weak var previewTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewTable.register(UINib(nibName: K.previewTable.nibNameCategoryTable, bundle: nil), forCellReuseIdentifier: K.previewTable.categoryTableCell)
        
        setupCustomUI()
    }
    
    func setupCustomUI(){
        CustomUI.setupAuthButton(btnCustom: previewBtn)
        CustomUI.setupAuthButton(btnCustom: menuBtn)
        CustomUI.setupAuthButton(btnCustom: categoryBtn)
    }

}

extension StoreViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = previewTable.dequeueReusableCell(withIdentifier: K.previewTable.categoryTableCell, for: indexPath) as! FoodPreviewTableViewCell
        
        cell.setupUI(category: StoreHandler.categoryCollection[indexPath.row])
        //cell.setupUI(order: orders[indexPath.row])
        
        return cell
    }
    
}
