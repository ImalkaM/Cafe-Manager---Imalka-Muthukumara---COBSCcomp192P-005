//
//  AddItemViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-15.
//

import UIKit
import Firebase

class AddItemViewController: UIViewController {
    var ref: DatabaseReference!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionfield: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var dicountField: UITextField!
    
    @IBOutlet weak var dropDownTable: UITableView!
    
    @IBOutlet weak var btnDrop: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        getCategorys()
        setupCustomUI()
        dropDownTable.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickDropButton(_ sender: Any) {
        dropDownTable.reloadData()
        if dropDownTable.isHidden {
            animate(toogle: true, type: btnDrop)
        } else {
            animate(toogle: false, type: btnDrop)
        }
    }
    
    func animate(toogle: Bool, type: UIButton) {
        
        if type == btnDrop {
            
            if toogle {
                UIView.animate(withDuration: 0.3) {
                    self.dropDownTable.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.dropDownTable.isHidden = true
                }
            }
        }
    }
    
    func setupCustomUI(){
        CustomUI.setupTextField(txtField: nameField)
        CustomUI.setupTextField(txtField: descriptionfield)
        CustomUI.setupTextField(txtField: priceField)
        CustomUI.setupTextField(txtField: dicountField)
        //CustomUI.setupAuthButton(btnCustom: priceField)
    }
    
    func getCategorys(){
        var category:Category = Category(categoryID: "", categoryName: "")
        self.ref.child("category").observe(.value) { (snapshot) in
            if let data = snapshot.value{
                if let orders = data as? [String:Any]{
                   StoreHandler.categoryCollection.removeAll()
                    for singleCategory in orders{
                        if let categoryInfo = singleCategory.value as? [String:Any]{
                            category.categoryName = categoryInfo["categoryName"] as! String
                            category.categoryID = singleCategory.key
                            StoreHandler.categoryCollection.append(category)
                        }
                    }
                }
            }
        }
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StoreHandler.categoryCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = StoreHandler.categoryCollection[indexPath.row].categoryName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        btnDrop.setTitle("\(StoreHandler.categoryCollection[indexPath.row].categoryName)", for: .normal)
        animate(toogle: false, type: btnDrop)
    }   
}
