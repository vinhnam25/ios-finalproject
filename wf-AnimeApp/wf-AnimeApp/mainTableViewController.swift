//
//  mainTableViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/4/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class mainTableViewController: UITableViewController {

    var list1 : [[String: AnyObject]] = [["Ten": "" as AnyObject, "SoLuotXem" : 0 as AnyObject, "SoTap": 0 as AnyObject, "Hinh1": "" as AnyObject, "SoTapHienCo": 0 as AnyObject]]
    var list2 : [[String: AnyObject]] = [["Ten": "" as AnyObject, "SoLuotXem" : 0 as AnyObject, "SoTap": 0 as AnyObject, "Hinh1": "" as AnyObject, "SoTapHienCo": 0 as AnyObject]]
    
    let titles = [ "Phim mới cập nhật", "Phim mới ra mắt"]
    var sectionData: [Int: [[String: AnyObject]]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sectionData = [0: self.list1, 1: self.list2]
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "icon_menu_50"),
            style: .plain,
            target: self.revealViewController(),
            action: #selector(SWRevealViewController.revealToggle(_:))
            )
        self.navigationItem.title = "AnimeFun"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        CallService1()
        CallService2()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let isLogin = UserDefaults.standard.bool(forKey: "isLogin")
        
        if isLogin {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Tủ phim",
                style: .plain,
                target: self,
                action: #selector(f_GoToWhsFilm)
            )
        }
        else {

            self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: #imageLiteral(resourceName: "icon_lock_50"),
                style: .plain,
                target: self,
                action: #selector(f_Login)
            )
        }
        
    }
    
    func f_Login()
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcLogin") as! loginViewController
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    func f_GoToWhsFilm()
    {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "vcWhs") as! logoutViewController
//        vc.modalTransitionStyle = .crossDissolve
//        self.present(vc, animated: true, completion: nil)
    }
    
    func CallService1() {
        let url: String = "http://ioswservice.somee.com/api/phim/TopUpdateRecent"
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let tk = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                print(error.debugDescription)
            }
            else {
                do {
                    self.sectionData[0] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String: AnyObject]]
                    
                    OperationQueue.main.addOperation {
                        //self.f_Finish(index: 0, list: self.list1)
                        
                        self.tableView.reloadData()
                        self.f_FinishService(index: 1)
                    }
                    
                }
                catch let err as NSError {
                    print(err)
                }
            }
        }
        
        tk.resume()

    }
    
    func CallService2() {
        let url: String = "http://ioswservice.somee.com/api/phim/TopReleaseNew"
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let tk = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                print(error.debugDescription)
            }
            else {
                do {
                    self.sectionData[1] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String: AnyObject]]
                    
                    OperationQueue.main.addOperation {

                        self.tableView.reloadData()
                        self.f_FinishService(index: 2)
                    }
                    
                }
                catch let err as NSError {
                    print(err)
                }
            }
        }
        
        tk.resume()
        
    }
    
    func f_FinishService(index: Int)
    {
        print(index)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return titles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (sectionData[section]?.count)!
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMain", for: indexPath) as!mainTableViewCell
        
        let list = sectionData[indexPath.section]!
        // Configure the cell...
        cell.NameLable.text = list[indexPath.row]["Ten"] as! String?
        cell.ShowImageView.showImgFrom(link: list[indexPath.row]["Hinh1"] as! String)
        
        let sotap = list[indexPath.row]["SoTap"] is NSNull || list[indexPath.row]["SoTap"] as! Int == 0 ? "??" : String(list[indexPath.row]["SoTap"] as! Int)
        let sotaphienco = String(list[indexPath.row]["SoTapHienCo"] as! Int)
        let luotxem = list[indexPath.row]["SoLuotXem"] as! NSNumber
        
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        
        cell.SoTapLable.text = "\(sotaphienco)/\(sotap)"
        cell.LuotXemLabel.text = numberFormatter.string(from: luotxem)
        
//        if indexPath.row % 2 == 0 {
//            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        }
//        else
//        {
//            cell.backgroundColor = #colorLiteral(red: 0.8505099416, green: 0.8505299091, blue: 0.8505191207, alpha: 1)
//        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x:0, y:0, width: tableView.frame.size.width, height: 18))
        let image = UIImageView(image: #imageLiteral(resourceName: "icon_menu"))
        image.frame = CGRect(x:5, y:5, width: 35, height:35)
        let label = UILabel(frame: CGRect(x:45, y:15, width:tableView.frame.size.width, height:18))
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = titles[section]
        view.addSubview(image)
        view.addSubview(label)
        view.backgroundColor = UIColor.gray // Set your background color
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcDetail") as! detailTableViewController
        
        var id: String = "0"
        let list = sectionData[indexPath.section]!
        
        id = String(list[indexPath.row]["ID"] as! Int)
        
        vc.CallService_LoadData(id: id)
        
        let navigationView = UINavigationController.init(rootViewController: vc)
        self.revealViewController().pushFrontViewController(navigationView, animated: true)
        //self.revealViewController().navigationController?.pushViewController(navigationView, animated: true)
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
