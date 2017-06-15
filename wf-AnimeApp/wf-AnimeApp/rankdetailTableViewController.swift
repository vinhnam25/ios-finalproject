//
//  rankdetailTableViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/14/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class rankdetailTableViewController: UITableViewController {

    var data : [[String: AnyObject]] = [[:]]
    var type = "0"
    var pos = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if type == "1"
        {
            title = "BXH Lượt xem"
        }
        else
        {
            title = "BXH Đánh giá"
        }
        
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
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    var viewIndicator = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 400))
    func setLoading() {
        
        viewIndicator = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.black
        activityIndicator.startAnimating()
        viewIndicator.addSubview(activityIndicator)
        viewIndicator.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(viewIndicator)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLoading()
    }
    
    func f_CallService(loai: String)
    {
        
        type = loai
        let url: String = "http://ioswservice.somee.com/api/phim/rank/\(loai)"
        
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
                        self.viewIndicator.isHidden = true
                        self.tableView.reloadData()
                    }
                    
                }
                catch let err as NSError {
                    print(err)
                }
            }
        }
        
        tk.resume()
    }
    
    func leftBarButtonItem_click()
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcmenuRank") as! rankmenuTableViewController
        let nav = UINavigationController.init(rootViewController: vc)
        self.revealViewController().pushFrontViewController(nav, animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath) as! rankdetailTableViewCell

        // Configure the cell...
        pos = indexPath.row + 1
        if let url = data[indexPath.row]["Hinh1"]
        {
            cell.hinhAnh.showImgFrom(link: url as! String, contentMode: .scaleToFill)
        }
        
        if let ten = data[indexPath.row]["Ten"]
        {
            cell.ten.text = ten as? String
        }
        else{
            cell.ten.text = "Loading..."
        }
        
        if type == "1"
        {
            if let val = data[indexPath.row]["SoLuotXem"]
            {
                let numberFormatter = NumberFormatter()
                numberFormatter.usesGroupingSeparator = true
                numberFormatter.groupingSeparator = ","
                numberFormatter.groupingSize = 3
                let x = val as! NSNumber
                
                cell.giatri.text = "\(numberFormatter.string(from: x )!)"
            }
            else
            {
                cell.giatri.text = "Loading..."
            }
        }
        else
        {
            if let val = data[indexPath.row]["DiemDanhGia"]
            {
                cell.giatri.text = "Đánh giá : \(String(val as! Double)) điểm"
            }
            else
            {
                cell.giatri.text = "Loading..."
            }

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
        cell.rankLabel.text = String(pos)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcDetail") as! detailTableViewController
        
        vc.viewStyle = 3
        vc.type = Int(type)!
        var id: String = "0"
        
        id = String(data[indexPath.row]["ID"] as! Int)
        
        vc.CallService_LoadData(id: id)
        
        let navigationView = UINavigationController.init(rootViewController: vc)
        self.revealViewController().pushFrontViewController(navigationView, animated: true)
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
