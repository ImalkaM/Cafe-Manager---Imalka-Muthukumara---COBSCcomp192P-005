//
//  AccountViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-28.
//

import UIKit
import Firebase
import SwiftDate

class AccountViewController: UIViewController{
    var ref: DatabaseReference!
    @IBOutlet weak var fromDateField: UITextField!
    @IBOutlet weak var toDateField: UITextField!
    
    @IBOutlet weak var accountTable: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    let datePickerFrom = UIDatePicker()
    let datePickerTo = UIDatePicker()
    
    let sessionMgr = SessionManager()
    
    var currentDate:Date = Date()
    //var tempFooditem =  [SoldFoodItems]()
    var fooodItemsSold = [SoldFoodItems]()
    var allSales =  [SalesDetails]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        accountTable.register(UINib(nibName: K.accountCell.nibNameAccountDetailsTable, bundle: nil), forCellReuseIdentifier: K.accountCell.accountTableCell)
        self.accountTable.rowHeight = UITableView.automaticDimension
        self.accountTable.estimatedRowHeight = 45
        
        createDatePickerFrom(textfield: fromDateField)
        createDatePickerTo(textfield: toDateField)
        
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        
        if self.presentingViewController != nil {
            self.dismiss(animated: false, completion: {
                self.sessionMgr.clearUserState()
                self.presentingViewController?.navigationController?.popViewController(animated: true)
                
            })
        }
        else {
            sessionMgr.clearUserState()
            self.presentingViewController?.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
extension AccountViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allSales.count == 0{
            self.accountTable.setEmptyMessage("Please select a Date Range To Show Sales Report")
        } else{
            self.accountTable.restore()
        }
        
        return allSales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = accountTable.dequeueReusableCell(withIdentifier: K.accountCell.accountTableCell, for: indexPath) as! AccountTableViewCell
        
        cell.setupView(salesDeatails: allSales[indexPath.row])
        
        //cell.setupUI(singleOrderDetails: tempFooditem[indexPath.row])
        cell.layoutSubviews()
        
        cell.layoutIfNeeded()
        return cell
    }
    
}

extension AccountViewController{
    
    func getSoldItemData(){
        
        var tempTotal = 0.0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        
        self.ref.child("sales")
            .observeSingleEvent(of: .value) { (snapshot) in
                if let categorys = snapshot.value as? [String: Any] {
                    // print(categorys.keys)//dates
                    self.allSales = []
                    for singleDate in categorys {
                        var singleSales = SoldFoodItems()
                        
                        // print(singleDate.key)//single date
                        //singleSales.totalPrice = singleFoodItem.value as! Double
                        if let singleFoodItem = singleDate.value as? [String: Any] {
                            
                            for singleFoodTotal in singleFoodItem {
                                
                                print(singleFoodTotal.value)
                                if let singleFoodTotalSub = singleFoodTotal.value as? [String: Any] {
                                    
                                    singleSales.foodName = singleFoodTotal.key
                                    singleSales.totalPrice = singleFoodTotalSub["\(singleSales.foodName)"] as! Double
                                    tempTotal += singleSales.totalPrice
                                   
                                    //print(singleSales.totalPrice)
                                }
                                self.fooodItemsSold.append(singleSales)
                            }
                           
                        }
                        
                        let replaced = singleDate.key.replacingOccurrences(of: "_", with: "-")
                        let datefromDB = replaced.toDate()
                        //print(self.datePickerFrom.date.inDefaultRegion())
                        let dbDateComapreRangeOrEqual =
                            datefromDB!.isInRange(date: self.datePickerFrom.date.inDefaultRegion(), and: self.datePickerTo.date.inDefaultRegion(),orEqual: true,granularity: .day)
                        let dbLeassThanToDateOrEqual = datefromDB!.isBeforeDate(self.datePickerTo.date.inDefaultRegion(), orEqual: true, granularity: .day)
                        //print(self.datePickerFrom.date)
                        if  dbDateComapreRangeOrEqual && dbLeassThanToDateOrEqual
                        
                        {
                            self.allSales.append(SalesDetails(dateSales: replaced,totalPriceAll: tempTotal, fooodItemsSold: self.fooodItemsSold))
                            tempTotal = 0.0
                            self.fooodItemsSold = []
                            // print(self.allSales)
                            DispatchQueue.main.async {
                                self.accountTable.reloadData()
                            }
                        }
                        
                    }
                    
                }
            }
    }
    
}
extension AccountViewController{
    
    func createDatePickerFrom(textfield:UITextField){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let donBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolBar.setItems([donBtn], animated: true)
        
        textfield.inputAccessoryView = toolBar
        
        textfield.inputView = datePickerFrom
        
        
        datePickerFrom.datePickerMode = .date
    }
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        
        //dateFormatter.timeStyle = .none
        
        fromDateField.text = dateFormatter.string(from: datePickerFrom.date)
        
        self.view.endEditing(true)
    }
    
    func createDatePickerTo(textfield:UITextField){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let donBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedTo))
        
        toolBar.setItems([donBtn], animated: true)
        
        textfield.inputAccessoryView = toolBar
        
        textfield.inputView = datePickerTo
        
        
        datePickerTo.datePickerMode = .date
    }
    
    @objc func donePressedTo(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        
        toDateField.text = dateFormatter.string(from: datePickerTo.date)
        self.fooodItemsSold = []
        DispatchQueue.main.async {
            self.accountTable.reloadData()
        }
        
        getSoldItemData()
        self.view.endEditing(true)
    }
}


