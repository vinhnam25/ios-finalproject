//
//  whsTableViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/14/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class whsTableViewController: UITableViewController {

    var data : [[String: AnyObject]] = [[:]]
    var isError = 0
    var viewStyle = 0
    var result = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        title = "Phim của tôi"
        
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
        if viewStyle == 0
        {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "vcMain") as! mainTableViewController
            let nav = UINavigationController.init(rootViewController: vc)
            self.revealViewController().pushFrontViewController(nav, animated: true)
        }
        
        if viewStyle == 1
        {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "vcAcc") as! accountTableViewController
            let nav = UINavigationController.init(rootViewController: vc)
            self.revealViewController().pushFrontViewController(nav, animated: true)
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
        if isError == 1 { return 0 }
        
        return data.count
    }

    func f_CallService()
    {
        let dict = UserDefaults.standard.value(forKey: "dict") as! [String: AnyObject]
        let id = dict["MaTK"] as! Int
        
        let url: String = "http://ioswservice.somee.com/api/phim/tuphim/\(id)"
        
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
                    print(err)
                    self.isError = 1
                    
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        tk.resume()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath) as! whsTableViewCell

        // Configure the cell...
        if let hinh = data[indexPath.row]["Hinh1"]
        {
            cell.hinh.showImgFrom(link: hinh as! String, contentMode: .scaleToFill)
        }
        
        if let val = data[indexPath.row]["Ten"] { cell.ten.text =  val as? String }
        else { cell.ten.text = "Loading..." }
        
        if let val = data[indexPath.row]["SoLuotXem"] {
            
            let numberFormatter = NumberFormatter()
            numberFormatter.usesGroupingSeparator = true
            numberFormatter.groupingSeparator = ","
            numberFormatter.groupingSize = 3
            let x = val as! NSNumber
            
            cell.luotxem.text = "\(numberFormatter.string(from: x )!)"
            cell.luotxem.iconLabel = #imageLiteral(resourceName: "icon_eye_50")
        } else { cell.luotxem.text = "Loading..." }

        if let val = data[indexPath.row]["DiemDanhGia"]
        {
            cell.danhgia.text = "\(String(val as! Double)) điểm"
            cell.danhgia.iconLabel = #imageLiteral(resourceName: "star_50")
        }
        else{
            cell.danhgia.text = "Loading..."
        }
        
        var sotap = ""
        var sotapall = ""
        let item = data[indexPath.row]
        
        if item["SoTapHienCo"] != nil
        {
            let val = (item["SoTapHienCo"] as? Int)!
            sotap = String(val)
        }
        else{
            sotap = "??"
        }
        
        if item["SoTap"] is NSNull == false && item["SoTap"] != nil
        {
            let val = (item["SoTap"] as? Int)!
            sotapall = String(val)
        }
        else{
            sotapall = "??"
        }
        
        cell.tap.text = "\(sotap)/\(sotapall)"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x:0, y:0, width: tableView.frame.size.width, height: 18))
        
        if(isError == 1)
        {
            let label = UILabel(frame: CGRect(x:60, y:15, width:tableView.frame.size.width, height:18))
            label.font = UIFont.systemFont(ofSize: 20)
            label.text = "Không có thông tin"
            view.addSubview(label)
            view.backgroundColor = UIColor.white // Set your background color
        
            return view
        }
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if isError == 0
        {
            return 0
        }
        else
        {
            return 45
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcDetail") as! detailTableViewController
        vc.viewStyle = 4
        vc.CallService_LoadData(id: String(data[indexPath.row]["ID"] as! Int))
        let nav = UINavigationController.init(rootViewController: vc)
        self.revealViewController().pushFrontViewController(nav, animated: true)
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let idPhim = String(data[indexPath.row]["ID"] as! Int)
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let dict = UserDefaults.standard.value(forKey: "dict") as! [String: AnyObject]
            let id = dict["MaTK"] as! Int
            
            let url: String = "http://ioswservice.somee.com/api/Phim/DelFromTuPhim"
            
            var urlRequest = URLRequest(url: URL(string: url)!)
            urlRequest.httpMethod = "POST"
            
            let postString = "taikhoan=\(id)&maphim=\(idPhim)"
            
            urlRequest.httpBody = postString.data(using: .utf8)
            
            let tk = URLSession.shared.dataTask(with: urlRequest)
            {
                (data, response, error) in
                if error != nil {
                    print("1: \(error.debugDescription)")
                }
                else {
                    
                    do {
                        self.result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! String
                        
                        OperationQueue.main.addOperation {
                            print("Da xoa khoi tu phim")
                        }
                        
                    }
                    catch let err as NSError {
                        print("2 : \(err)")
                        
                    }
                }
            }
            
            tk.resume()
            
            
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

}
