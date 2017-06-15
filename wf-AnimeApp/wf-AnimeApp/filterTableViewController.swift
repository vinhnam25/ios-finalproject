//
//  filterTableViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/14/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class filterTableViewController: UITableViewController, PassDataDelegate {

    @IBOutlet weak var keywordTextField: DesignableTextField!
    @IBOutlet weak var theLoaiTextField: DesignableTextField!
    @IBOutlet weak var nhomDichTextField: DesignableTextField!
    @IBOutlet weak var loaiPhimTextField: DesignableTextField!
    @IBOutlet weak var namTextField: DesignableTextField!
    
    var theLoaiID = 0
    var fansubID = 0
    var loaiPhimID = 0
    var nam = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let rel = self.revealViewController()
        {
            self.view.addGestureRecognizer(rel.panGestureRecognizer())
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backMenu_Click(_ sender: Any) {
        self.revealViewController().revealToggle(sender)
    }
    
    @IBAction func timKiemButton_Click(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcList") as! listViewController
        
        vc.viewStyle = 2
        var keyword = ""
        
        if keywordTextField.text! == ""
        {
            keyword = "-1"
        }
        else{
            keyword = keywordTextField.text!
        }
        
        vc.f_SearchService(keyword: keyword, theloai: theLoaiID, loaiphim: loaiPhimID, nam: nam, fansub: fansubID)
        
        let navigationView = UINavigationController.init(rootViewController: vc)
        self.revealViewController().pushFrontViewController(navigationView, animated: true)
    }
    
    @IBAction func theloai_click(_ sender: Any) {
        f_GoToView(type: 1)
    }
    
    @IBAction func fansub_click(_ sender: Any) {
        f_GoToView(type: 3)
    }
    
    @IBAction func loaiPhim_Click(_ sender: Any) {
        f_GoToView(type: 5)
    }
    
    @IBAction func namButton_Click(_ sender: Any) {
        f_GoToView(type: 4)
    }
    
    func f_GoToView(type: Int)
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcReposi") as! reposiTableViewController

        vc.viewStyle = 1
        vc.f_callService(type: type)
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        let navigationView = UINavigationController.init(rootViewController: vc)
        present(navigationView, animated: true)
    }
    
    func f_GetValue(item: [String : AnyObject], type: Int) {
        
        if type == 1
        {
            theLoaiID = item["ID"] as! Int
            if let ten = item["Ten"]
            {
                theLoaiTextField.text! = ten as! String
            }
            else{
                theLoaiTextField.text! = ""
            }
        }
        
        if type == 5
        {
            loaiPhimID = item["ID"] as! Int
            if let ten = item["Ten"]
            {
                loaiPhimTextField.text! = ten as! String
            }
            else{
                loaiPhimTextField.text! = ""
            }
        }
        
        if type == 3
        {
            fansubID = item["ID"] as! Int
            if let ten = item["TenNhom"]
            {
                nhomDichTextField.text! = ten as! String
            }
            else{
                nhomDichTextField.text! = ""
            }
        }
        
        if type == 4
        {
            if let ten = item["Nam"]
            {
                nam = ten as! Int
                namTextField.text! = String(nam)
            }
            else{
                namTextField.text! = ""
            }
        }
    }
    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
