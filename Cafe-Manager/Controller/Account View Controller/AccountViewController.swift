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
   // let london = Region(calendar: .gregorian, zone: .europeLondon, locale: .italian)
    var ref: DatabaseReference!
    @IBOutlet weak var fromDateField: UITextField!
    @IBOutlet weak var toDateField: UITextField!
    
    @IBOutlet weak var accountTable: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    let datePickerFrom = UIDatePicker()
    let datePickerTo = UIDatePicker()
    
    var currentDate:Date = Date()
    var dateValue: Date? {
        let dateAsString = "13:15"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+00:00")//Add this
        let date = dateFormatter.date(from: dateAsString)
            return date
           }
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
        
        print(dateValue)
    }
    
}
extension AccountViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
      //  print(dateFormatter.string(from: datePickerTo.date))
       
     //   print(datePickerTo.date.date.toFormat("dd-MM-yyyy"))
        
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
                                    self.fooodItemsSold.append(singleSales)
                                    print(singleSales.totalPrice)
                                }
                            }
                        }
                        let replaced = singleDate.key.replacingOccurrences(of: "_", with: "-")
                        var tfg = "2010-05-20"
                        print(replaced)
                        let ghf = dateFormatter.date(from: replaced)
                        let dateInNY = replaced.toDate("yyyy-MM-dd")
                       // let finalDateDBb = dateInNY?.toFormat("dd-MM-yyyy")
                       print(ghf)
                        
                        if  dateInNY!.date.isAfterDate(self.datePickerFrom.date , orEqual: true, granularity: .year)
                                && dateInNY!.date.isBeforeDate(self.datePickerTo.date ,orEqual: true, granularity: .year){
                                
                            self.allSales.append(SalesDetails(dateSales: replaced, fooodItemsSold: self.fooodItemsSold))
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
        
        getSoldItemData()
        self.view.endEditing(true)
    }
}

