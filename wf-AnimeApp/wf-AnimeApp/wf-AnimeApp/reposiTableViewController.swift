//
//  reposiTableViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/13/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

protocol PassDataDelegate: class {
    func f_GetValue(item: [String: AnyObject], type: Int)
}

class reposiTableViewController: UITableViewController {

    var data: [[String: AnyObject]] = [[:]]
    var type = 0
    var _tt = ""
    var viewStyle = 0
    
    var delegate : PassDataDelegate?
    
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
        
        title = _tt
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "icon_back_50"),
            style: .plain,
            target: self,
            action: #selector(leftBarButtonItem_click)
        )
    }
    
    func leftBarButtonItem_click()
    {
        
        if viewStyle == 0
        {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "vcCustom") as! customViewController
            self.revealViewController().pushFrontViewController(vc, animated: true)
        }
        
        if viewStyle == 1
        {
            dismiss(animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath) as! reposiTableViewCell

        // Configure the cell...
        
        if type == 3
        {
            cell.contentLabel.text = data[indexPath.row]["TenNhom"] as? String
        }
        else if type == 1 || type == 5 {
            cell.contentLabel.text = data[indexPath.row]["Ten"] as? String
        }
        else if type == 2 {
            cell.contentLabel.text = data[indexPath.row]["TenNSX"] as? String
        }
        else if type == 4 {
            cell.contentLabel.text = String(data[indexPath.row]["Nam"] as! Int)
        }
        
        return cell
    }
    
    func f_callService(type: Int)
    {
        self.type = type
        var url: String = ""
        
        if type == 3
        {
            url = "http://ioswservice.somee.com/api/fansub/getall"
            _tt = "Nhóm dịch"
        }
        else if type == 1 {
            url = "http://ioswservice.somee.com/api/theloai/getall"
            _tt = "Thể loại"
        }
        else if type == 2 {
            url = "http://ioswservice.somee.com/api/nsx/getall"
            _tt = "Nhà sản xuất"
        }
        else if type == 5 {
            url = "http://ioswservice.somee.com/api/phim/layLoaiPhim"
            _tt = "Loại phim"
        }
        else if type == 4 {
            
            _tt = "Năm phát hành"
            data.removeAll()
            let date = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            var item : [String: Int] = ["Nam": 0]
            for var i in 2000...components.year!
            {
                item["Nam"] = i
                data.append(item as [String : AnyObject])
            }
            return
        }
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let tk = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                print(error.debugDescription)
            }
            else {
                do {
                    self.data = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                    
                }
                catch let err as NSError {

                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                    
                    print("2: \(err)")
                }
            }
        }
        
        tk.resume()

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if viewStyle == 0
        {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "vcList") as! listViewController
            
            let val = data[indexPath.row]["ID"] as? Int
            vc.viewStyle = 1
            vc.f_CallService(type: type, vaue: val!)
            
            let navigationView = UINavigationController.init(rootViewController: vc)
            self.revealViewController().pushFrontViewController(navigationView, animated: true)
        }
        
        if viewStyle == 1
        {
            delegate?.f_GetValue(item: data[indexPath.row], type: type)
            dismiss(animated: true)
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
