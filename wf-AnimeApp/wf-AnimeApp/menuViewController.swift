//
//  menuViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/4/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class menuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var menuDictText = [
        "cell1" : "Trang chủ",
        "cell2" : "Xem danh sách phim",
        "cell3" : "Lọc phim",
        "cell4" : "Bảng xếp hạng"
    ]
    
    var menuDictIcon = [
        "cell1" : #imageLiteral(resourceName: "icon_home"),
        "cell2" : #imageLiteral(resourceName: "icon_list"),
        "cell3" : #imageLiteral(resourceName: "icon_search"),
        "cell4" : #imageLiteral(resourceName: "icon_rank")
    ]
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        menuTableView.tableFooterView = UIView(frame: .zero)
        
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.layer.masksToBounds = false
        avatarImageView.clipsToBounds = true
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        let isLogin = UserDefaults.standard.bool(forKey: "isLogin")
        
        if isLogin {
            let dict = UserDefaults.standard.value(forKey: "dict") as! [String: AnyObject]
            nameLabel.text! = dict["HoTen"] as! String
            
            menuDictText["cell5"] = "Tài khoản"
            menuDictIcon["cell5"] = #imageLiteral(resourceName: "account_100")
            
            menuDictText["cell6"] = "Đăng xuât"
            menuDictIcon["cell6"] = #imageLiteral(resourceName: "icon_logout")
            
            if dict["TenDN"] as! String == "admin" {
                menuDictText["cell7"] = "Quản trị"
                menuDictIcon["cell7"] = #imageLiteral(resourceName: "icon_admin")
            }
            else
            {
                menuDictText["cell7"] = ""
                menuDictIcon.removeValue(forKey: "cell7")
            }
            
        }
        else {
            nameLabel.text! = "Khách"
            
            menuDictText["cell5"] = ""
            menuDictText["cell6"] = ""
            menuDictText["cell7"] = ""
            
            menuDictText.removeValue(forKey: "cell5")
            menuDictText.removeValue(forKey: "cell6")
            menuDictIcon.removeValue(forKey: "cell7")
        }
        
        menuTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuDictText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let key = Array(menuDictText.keys).sorted{$0.0 < $0.1}[indexPath.row]
        let cellContent = tableView.dequeueReusableCell(withIdentifier: key, for: indexPath)
        
        cellContent.textLabel?.text = menuDictText[key]
        cellContent.textLabel?.textColor = UIColor.white
        
        cellContent.imageView?.image = menuDictIcon[key]
        cellContent.imageView?.tintColor = UIColor.white
        
        return cellContent
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
