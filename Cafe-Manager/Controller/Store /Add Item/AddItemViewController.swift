//
//  AddItemViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-15.
//

import UIKit
import Firebase
import Loaf

class AddItemViewController: UIViewController {
    var ref: DatabaseReference!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionfield: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var dicountField: UITextField!
    
    @IBOutlet weak var dropDownTable: UITableView!
    
    @IBOutlet weak var btnDrop: UIButton!
    
    @IBOutlet weak var avaialableButton: UISwitch!
    
    @IBOutlet weak var addButton: UIButton!
    
    
    @IBOutlet weak var imagepicked: UIImageView!
    
    var tempFoodItem:FoodItem = FoodItem(id: "", foodName: "", foodDescription: "", category: "", foodPrice: 0.0, discount: 0, image: "", isAvailable: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        getCategorys()
        setupCustomUI()
        dropDownTable.isHidden = true
        
    }
    @IBAction func availableSwitch(_ sender: UISwitch) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        if let name = nameField.text, let description = descriptionfield.text, let price = priceField.text
        {
            if name.isEmpty{
                Loaf("Food Name cannot be empty!", state: .error, sender: self).show()
                return
            }
            if description.isEmpty{
                Loaf("Description cannot be empty!", state: .error, sender: self).show()
                return
            }
            if price.isEmpty {
                
                Loaf("Price cannot be empty!", state: .error, sender: self).show()
                return
                
            }
            guard let im: UIImage = imagepicked.image else { return }
            guard let d: Data = im.jpegData(compressionQuality: 0.5) else { return }

            let md = StorageMetadata()
            md.contentType = "image/png"

            let f = "foodImage/" + UUID().uuidString + ".jpg"
            let ref = Storage.storage().reference().child(f)
            createSpinnerView() 
            ref.putData(d, metadata: md) { (metadata, error) in
                if error == nil {
                    ref.downloadURL(completion: { (url, error) in
                        self.tempFoodItem.image = url?.absoluteString ?? ""
                        self.tempFoodItem.isAvailable = self.avaialableButton.isOn
                        self.tempFoodItem.foodName = name
                        self.tempFoodItem.foodDescription = description
                        self.tempFoodItem.discount = Int(self.dicountField.text ?? "") ?? 0
                        self.tempFoodItem.foodPrice = Double(price) ?? 0
                        //tempFoodItem.image = imagepicked.
                        
                        self.createFoodItem(foodItem: self.tempFoodItem)
                        print("Done, url is \(String(describing: url))")
                    })
                }else{
                    print("error \(String(describing: error))")
                }
            }
            
            
           
        }
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
       CustomUI.setupAuthButton(btnCustom: addButton)
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
    
    
    @IBAction func selectImagePressed(_ sender: UIButton) {
        
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
        
        
    }
    
    func createFoodItem(foodItem: FoodItem){
        let categoryData = [
            "foodName" : foodItem.foodName,
            "foodDescription" : foodItem.foodDescription,
            "price" : foodItem.foodPrice,
            "discount" : foodItem.discount,
            "available" : foodItem.isAvailable,
            "imageURL" : foodItem.image
        ] as [String : Any]
        self.ref.child("FoodItemsCafe")
            .child(foodItem.category)
            .childByAutoId()
            .setValue(categoryData){ (error, ref) in
                if let err =  error{
                    Loaf("\(err.localizedDescription)", state: .error, sender: self).show()
                }
                else{
                    //self.categoryTable.reloadData()
                    Loaf("Category added successfully", state: .success, sender: self).show()
                    self.dismiss(animated: true, completion: nil)
                }
            }
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
        tempFoodItem.category = StoreHandler.categoryCollection[indexPath.row].categoryName
    }
    
}

extension AddItemViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       picker.dismiss(animated: true, completion: nil)
        
        
        if let image = info[.originalImage] as? UIImage{
            
            imagepicked.image = image
        }
        
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
}
