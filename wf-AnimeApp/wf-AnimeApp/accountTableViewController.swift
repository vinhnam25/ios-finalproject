//
//  accountTableViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/15/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class accountTableViewController: UITableViewController {

    var data = [
        ["name" : " Đổi mật khẩu", "type": 1],
        ["name" : " Cập nhật thông tin", "type": 2],
        ["name" : " Vào kho phim", "type": 3]
    ]
    
    var images : [UIImage] = [#imageLiteral(resourceName: "changepass_50"),#imageLiteral(resourceName: "changeprofile_50"), #imageLiteral(resourceName: "box_50")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        title = "Tài khoản"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "icon_menu_50"),
            style: .plain,
            target: self.revealViewController(),
            action: #selector(SWRevealViewController.revealToggle(_:))
        )
        
        if let rel = self.revealViewController()
        {
            self.view.addGestureRecognizer(rel.panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath) as! accountTableViewCell

        // Configure the cell...
        cell.contentLabel.text = data[indexPath.row]["name"] as! String?
        cell.contentLabel.iconLabel = images[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        if indexPath.row == 0 //doi mat khau
        {
            let vc = sb.instantiateViewController(withIdentifier: "vcChangePass") as! changepassTableViewController
            let nav = UINavigationController.init(rootViewController: vc)
            self.revealViewController().pushFrontViewController(nav, animated: true)
        }
        
        if indexPath.row  == 1 //cap nhat tai khoan
        {
            let vc = sb.instantiateViewController(withIdentifier: "vcChangePro") as! changeprofileTableViewController
            let nav = UINavigationController.init(rootViewController: vc)
            self.revealViewController().pushFrontViewController(nav, animated: true)
        }
        
        if indexPath.row == 2 //vao kho phim
        {
            let vc = sb.instantiateViewController(withIdentifier: "vcWhs") as! whsTableViewController
            vc.viewStyle = 1
            vc.f_CallService()
            let nav = UINavigationController.init(rootViewController: vc)
            self.revealViewController().pushFrontViewController(nav, animated: true)

        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
