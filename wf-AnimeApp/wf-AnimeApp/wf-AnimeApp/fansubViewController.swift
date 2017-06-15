//
//  fansubViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/13/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class fansubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var fantableView: UITableView!

    var data : [String: AnyObject] = [:]
    var fansub : [[String: AnyObject]] = [[:]]
    var quality : [[String]] = []
    var sectionData: [Int : [String]] = [:]
    var id = "0"
    var noData : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fantableView.tableFooterView = UIView(frame: .zero)
        
        // Do any additional setup after loading the view.
        if let rel = self.revealViewController()
        {
            self.view.addGestureRecognizer(rel.panGestureRecognizer())
        }
        
        title = "Chọn nhóm dịch"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "icon_back_50"),
            style: .plain,
            target: self,
            action: #selector(leftBarButtonItem_click)
        )
        
    }
    
    func leftBarButtonItem_click()
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcDetail") as! detailTableViewController
        vc.CallService_LoadData(id: id)
        let vcNav = UINavigationController.init(rootViewController: vc)
        self.revealViewController().pushFrontViewController(vcNav, animated: true)
    }
    
    func CallService() {
        let url: String = "http://ioswservice.somee.com/api/phim/Subteam/\(id)"
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let tk = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                print(error.debugDescription)
            }
            else {
                do {
                    self.data = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
                    
                    self.fansub = self.data["fansubs"] as! [[String: AnyObject]]
                    self.quality = self.data["chatluong"] as! [[String]]
                    
                    for i in 0..<self.quality.count
                    {
                        self.sectionData[i] = self.quality[i]
                    }
                    
                    OperationQueue.main.addOperation {
                        self.fantableView.reloadData()
                    }
                    
                }
                catch let err as NSError {
                    self.noData = true
                    
                    OperationQueue.main.addOperation {
                        self.fantableView.reloadData()
                    }
                    
                    print("2: \(err)")
                }
            }
        }
        
        tk.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return fansub.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionData.isEmpty
        {
            return 0
        }
        else
        {
            return (sectionData[section]?.count)!
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellfan", for: indexPath) as! fansubTableViewCell
        
        if let item = sectionData[indexPath.section]
        {
            cell.chatLuongLabel.text = item[indexPath.row]
        }
        else
        {
            cell.chatLuongLabel.text = "Loading..."
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x:0, y:0, width: tableView.frame.size.width, height: 18))
        let label = UILabel(frame: CGRect(x:45, y:15, width:tableView.frame.size.width, height:18))
        label.font = UIFont.systemFont(ofSize: 20)
        
        let item = fansub[section]
        
        if let ten = item["TenNhom"]
        {
            label.text = ten as? String
        }
        else
        {
            label.text = "Loading..."
        }
        
        if(noData)
        {
            label.text = "Không có nhóm sub nào"
        }
        
        view.addSubview(label)
        view.backgroundColor = UIColor.cyan // Set your background color
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcEploise") as! eploiseViewController
        
        let list = sectionData[indexPath.section]!
        let quality = list[indexPath.row]
        let nhomsub = fansub[indexPath.section]["ID"] as! Int
        let ten = fansub[indexPath.section]["TenNhom"] as? String
        
        vc.tennhomdich = ten!
        
        vc.f_CallService(id: id, fansub: String(nhomsub), quality: quality)
        
        let navigationView = UINavigationController.init(rootViewController: vc)
        self.revealViewController().pushFrontViewController(navigationView, animated: true)
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
