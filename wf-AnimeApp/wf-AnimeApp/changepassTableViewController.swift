//
//  changepassTableViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/15/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class changepassTableViewController: UITableViewController {

    @IBOutlet weak var passOld: DesignableTextField!
    @IBOutlet weak var passNew: DesignableTextField!
    @IBOutlet weak var passcf: DesignableTextField!
    
    var result : [String : AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        passOld.isSecureTextEntry = true
        passNew.isSecureTextEntry = true
        passcf.isSecureTextEntry = true
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        title = "Đổi mật khẩu"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "icon_back_50"),
            style: .plain,
            target: self,
            action: #selector(leftBarButtonItem_click)
        )
        
        if let rel = self.revealViewController()
        {
            self.view.addGestureRecognizer(rel.panGestureRecognizer())
        }
    }

    func leftBarButtonItem_click()
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcAcc") as! accountTableViewController
        let nav = UINavigationController.init(rootViewController: vc)
        self.revealViewController().pushFrontViewController(nav, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func change_click(_ sender: Any) {
        
        if f_ValidateAll()
        {
            let dict = UserDefaults.standard.value(forKey: "dict") as! [String: AnyObject]
            let id = dict["MaTK"] as! Int
            
            let url: String = "http://ioswservice.somee.com/api/TaiKhoan/ChangePass"
            
            var urlRequest = URLRequest(url: URL(string: url)!)
            urlRequest.httpMethod = "POST"
            
            let postString = "id=\(id)&passOld=\(passOld.text!)&passNew=\(passNew.text!)"
            
            urlRequest.httpBody = postString.data(using: .utf8)
            
            let tk = URLSession.shared.dataTask(with: urlRequest)
            {
                (data, response, error) in
                if error != nil {
                    print(error.debugDescription)
                }
                else {
                    
                    do {
                        self.result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : AnyObject]
                        
                        OperationQueue.main.addOperation {
                            
                            let msg = self.result["msg"] as? String
                            self.f_ShowAlert_OK(title: "Thông báo", mess: msg!)
                    
                        }
                        
                    }
                    catch let err as NSError {
                        print(err)
                        self.f_ShowAlert_OK(title: "Lỗi", mess: "Lỗi xử lý hoặc kết nối máy chủ !")
                    }
                }
            }
            
            tk.resume()
        }
        
    }
    
    func f_ValidateAll() -> Bool
    {
        if passOld.text! == ""
        {
            f_ShowAlert_OK(title: "Lỗi", mess: "Chưa nhập tên đăng nhập !")
            return false
        }
        
        if passNew.text! == ""
        {
            f_ShowAlert_OK(title: "Lỗi", mess: "Chưa nhập mật khẩu !")
            return false
        }
        
        if passcf.text! != passNew.text!
        {
            f_ShowAlert_OK(title: "Lỗi", mess: "Mật khẩu nhập lại không đúng !")
            return false
        }
        
        return true
    }
    
    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
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
