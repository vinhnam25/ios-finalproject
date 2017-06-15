//
//  quanLyNSXTableViewController.swift
//  wf-AnimeApp
//
//  Created by Nam Tran on 6/15/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class quanLyNSXTableViewController: UITableViewController {
    var data : [[String : AnyObject]] = [[:]]
    var id : [[Int]] = []
    var ten : [[String]] = []
    var result : String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        f_GetAllNSX()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "nsxCell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]["TenNSX"] as? String
        return cell
    }
    
    func f_GetAllNSX() {
        
        let url: String = "http://ioswservice.somee.com/api/nsx/getall"
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let tk = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                print(error.debugDescription)
            }
            else {
                do {
                    self.data = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    print(self.data as Any)
                    OperationQueue.main.addOperation {
                        
                        self.tableView.reloadData()
                        print("get all nsx")
                    }
                    
                }
                catch let err as NSError {
                    print(err)
                }
            }
        }
        
        tk.resume()
    }
    
    @IBAction func unwindToQuanLyNSX(segue:UIStoryboardSegue) {
        
    }    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            XoaNSX(id: indexPath.row)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

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
    
    func XoaNSX(id: Int) {
        let url: String = "http://ioswservice.somee.com/api/nsx/xoa/"
        var urlRequest = URLRequest(url: URL(string: url)!)
        
        let tk = URLSession.shared.dataTask(with: urlRequest)
        {
            (data, response, error) in
            if error != nil {
                print(error.debugDescription)
            }
            else {
                
                do {
                    self.result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! String
                    
                    OperationQueue.main.addOperation {
                        if self.result == "1"
                        {
                            self.f_ShowAlert_OK(title: "Thông báo", mess: "Xoá nhà sản xuất thành công.")
                        }
                        else{
                            self.f_ShowAlert_OK(title: "Thông báo", mess: "Không xoá được nhà sản xuất!")
                        }
                        
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

class themNSXTableViewController : UITableViewController {
    var result : String = "0"
    var index: Int?
    var editedTheLoai: String?
    @IBOutlet var tenNSX: UITextField!
    
    @IBAction func save(sender: AnyObject) {
        luuNSX()
        dismiss(animated: true, completion: nil)
    }
    
    func luuNSX(){
        if(true) //!isEdit
        {
            let url: String = "http://ioswservice.somee.com/api/nsx/add"
            
            var urlRequest = URLRequest(url: URL(string: url)!)
            urlRequest.httpMethod = "POST"
            
            let postString = "Ten=\(tenNSX.text!)"
            
            urlRequest.httpBody = postString.data(using: .utf8)
            
            let tk = URLSession.shared.dataTask(with: urlRequest)
            {
                (data, response, error) in
                if error != nil {
                    print(error.debugDescription)
                }
                else {
                    
                    do {
                        self.result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! String
                        
                        OperationQueue.main.addOperation {
                            if self.result == "1"
                            {
                                self.f_ShowAlert_OK(title: "Thông báo", mess: "Thêm nhà sản xuất thành công.")
                            }
                            else{
                                self.f_ShowAlert_OK(title: "Thông báo", mess: "Không thêm được nhà sản xuất!")
                            }
                            
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
        else {
            let url: String = "http://ioswservice.somee.com/api/nsx/CapNhat"
            
            var urlRequest = URLRequest(url: URL(string: url)!)
            urlRequest.httpMethod = "POST"
            
            let postString = "ten=\(tenNSX.text!)&"
            
            urlRequest.httpBody = postString.data(using: .utf8)
            
            let tk = URLSession.shared.dataTask(with: urlRequest)
            {
                (data, response, error) in
                if error != nil {
                    print(error.debugDescription)
                }
                else {
                    
                    do {
                        self.result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! String
                        
                        OperationQueue.main.addOperation {
                            if self.result == "1"
                            {
                                self.f_ShowAlert_OK(title: "Thông báo", mess: "Cập nhật nhà sản xuất thành công.")
                            }
                            else{
                                self.f_ShowAlert_OK(title: "Thông báo", mess: "Không cập nhật được nhà sản xuất!")
                            }
                            
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
}
