//
//  AddCategoryViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-14.
//

import UIKit

class AddCategoryViewController: UIViewController {
    
    var category:[Category] = []

    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var categoryTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomUI()
        categoryTable.register(UINib(nibName: K.category.nibNameCategoryTable, bundle: nil), forCellReuseIdentifier: K.category.categoryTableCell)
    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        category.append(Category(categoryID: "1", categoryName: categoryTextField.text ?? ""))
        categoryTable.reloadData()
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func setupCustomUI(){
        CustomUI.setupTextField(txtField: categoryTextField)
        CustomUI.setupAuthButton(btnCustom: addButton)
    }
}

extension AddCategoryViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryTable.dequeueReusableCell(withIdentifier: K.category.categoryTableCell, for: indexPath) as! CategoryTableViewCell
        
        cell.setupUI(category: category[indexPath.row])
        //cell.setupUI(order: orders[indexPath.row])
        
        return cell
    }
    
}
extension AddCategoryViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            category.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)
           } else if editingStyle == .insert {
               // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
           }
    }
}
