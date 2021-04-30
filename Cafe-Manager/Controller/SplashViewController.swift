//
//  SplashViewController.swift
//  Cafe-Manager
//
//  Created by Imalka Muthukumara on 2021-04-30.
//

import UIKit

class SplashViewController: UIViewController {
    let sessionMgr = SessionManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        if sessionMgr.getUserLoggedState(){
            performSegue(withIdentifier: K.launchToHomeSeauge, sender: self)
        }else{
            performSegue(withIdentifier: K.launchToLogin, sender: self)
        }
    }
}
