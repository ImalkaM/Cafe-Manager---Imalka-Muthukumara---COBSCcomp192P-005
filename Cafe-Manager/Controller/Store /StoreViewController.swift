//
//  StoreViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-14.
//

import UIKit
import Firebase

class StoreViewController: UIViewController{
    var ref = Database.database().reference()
    
    var category:Category = Category(categoryID: "", categoryName: "")
    
    var categoryCollection:[Category] = [Category(categoryID: "Main", categoryName: "fruits"),Category(categoryID: "sda", categoryName: "ssadad")]
    
    var categoryWiseFoods:[CategoryItems] = []
    var tempCatName:String = ""
    
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var categoryBtn: UIButton!
    
    @IBOutlet weak var previewTable: UITableView!
    
    var foodItemArray:[FoodItem] = []
    
    private let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getCategorys()
        
        // getFoodItemsadss()
        //getFoodItems()
        ref = Database.database().reference()
        previewTable.register(UINib(nibName: K.previewTable.nibNameCategoryTable, bundle: nil), forCellReuseIdentifier: K.previewTable.categoryTableCell)
        
        setupCustomUI()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //getCategorys()
        //getFoodItems()
        getFoodItemsnew()
        
    }
    func setupCustomUI(){
        CustomUI.setupAuthButton(btnCustom: previewBtn)
        CustomUI.setupAuthButton(btnCustom: menuBtn)
        CustomUI.setupAuthButton(btnCustom: categoryBtn)
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()
        
        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
}

extension StoreViewController:UITableViewDataSource,foodAvailableDelegate,UITableViewDelegate {
    
    func availableButtonToggled(at indexPath: IndexPath,isOn: Bool, foodItem: FoodItem) {
        
        // print(self.categoryWiseFoods[indexPath.section].name)
        ref.child("FoodItemsCafe").child(self.categoryWiseFoods[indexPath.section].name).child(foodItem.id).child("available").setValue(isOn){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                //error
            } else {
                //self.getFoodItems()
                //self.foodItemArray.remove(at: indexPath.row)
            }
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = #colorLiteral(red: 1, green: 0.3653766513, blue: 0.1507387459, alpha: 1)
        
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.text = categoryWiseFoods[section].name
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryWiseFoods[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = previewTable.dequeueReusableCell(withIdentifier: K.previewTable.categoryTableCell, for: indexPath) as! FoodPreviewTableViewCell
        
        let category = categoryWiseFoods[indexPath.section]
        let singleCatItem = category.items[indexPath.row]
        
        let sectionHeaderView = previewTable.headerView(forSection: indexPath.section)
        let sectionTitle = sectionHeaderView?.textLabel?.text ?? ""
        
        cell.setupView(foodItem: singleCatItem, categoryName: sectionTitle)
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        categoryWiseFoods.count
    }
}

extension StoreViewController{
    
    func getFoodItemsnew(){
        createSpinnerView()
        self.categoryWiseFoods = []
        
        //for categorys in StoreHandler.categoryCollection{
        
        self.ref.child("FoodItemsCafe")
            .observeSingleEvent(of:.value) { (snapshot) in
                
                self.categoryWiseFoods = []
                if let categorys = snapshot.value as? [String: Any] {
                    
                    for singlecategory in categorys {
                        print(singlecategory.key)//cat name
                        if let singleFoodItem = singlecategory.value as? [String: Any] {
                            for foodItemDetail in singleFoodItem {
                                var foodItems = FoodItem()
                                if let itemInfo = foodItemDetail.value as? [String:Any]{
                                    
                                    foodItems.id = foodItemDetail.key
                                    foodItems.foodName = itemInfo["foodName"] as! String
                                    foodItems.foodDescription = itemInfo["foodDescription"] as! String
                                    foodItems.foodPrice = itemInfo["price"] as! Double
                                    foodItems.discount = itemInfo["discount"] as! Int
                                    foodItems.isAvailable = itemInfo["available"] as! Bool
                                    foodItems.image = itemInfo["imageURL"] as! String
                                    
                                    print(foodItems)
                                    
                                }
                                //print(foodItemDetails.key)//single item key
                                
                                self.foodItemArray.append(foodItems)
                                
                            }
                            
                        }
                        self.categoryWiseFoods.append(CategoryItems(name: singlecategory.key, items: self.foodItemArray))
                        self.foodItemArray = []
                    }
                    DispatchQueue.main.async {
                        self.previewTable.reloadData()
                    }
                }
            }
    }
    
}
