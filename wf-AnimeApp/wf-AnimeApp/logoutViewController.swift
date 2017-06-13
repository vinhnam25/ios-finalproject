//
//  logoutViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/6/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class logoutViewController: UIViewController, AlertOKDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let rel = self.revealViewController()
        {
            self.view.addGestureRecognizer(rel.panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton_Click(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcMain") as! mainTableViewController
        let vcNav = UINavigationController.init(rootViewController: vc)
        self.revealViewController().pushFrontViewController(vcNav, animated: true)
    }
    
    @IBAction func thoatButton_Click(_ sender: Any) {
        let dict = ["MaTK": 0, "HoTen": "", "TenDN": ""] as [String : Any]
        UserDefaults.standard.set(dict, forKey: "dict")
        UserDefaults.standard.set(false, forKey: "isLogin")
        
        f_ShowAlert_OK(title: "Thông báo", mess: "Bạn đã thoát tài khoản.", delegate: self)
    }
    
    
    func f_Handel_OK() {
        //dismiss(animated: true, completion: nil)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcMain") as! mainTableViewController
        //let navigationView = UINavigationController.init(rootViewController: vc)
        let vcNav = UINavigationController.init(rootViewController: vc)
        self.revealViewController().pushFrontViewController(vcNav, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
