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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomUI()
    }
    
    func setupCustomUI(){
        CustomUI.setupAuthButton(btnCustom: previewBtn)
        CustomUI.setupAuthButton(btnCustom: menuBtn)
        CustomUI.setupAuthButton(btnCustom: categoryBtn)
    }

}
