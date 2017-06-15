//
//  detailTableViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/7/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class detailTableViewController: UITableViewController {

    @IBOutlet weak var imgBigImageView: UIImageView!
    @IBOutlet weak var imgSmlImageView: UIImageView!
    @IBOutlet weak var tenLabel: UILabel!
    @IBOutlet weak var theLoaiLabel: UILabel!
    @IBOutlet weak var nsxLable: UILabel!
    @IBOutlet weak var fansubLabel: UILabel!
    @IBOutlet weak var sotapLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var uotxemLabel: UILabel!
    @IBOutlet weak var favoLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var idPhim = "0"
    var item = [String : AnyObject]()
    var viewStyle = 0
    var type = 0
    var val = 0
    
    var keyword = ""
    var theloai = 0
    var loaiphim = 0
    var nam = 0
    var fansub = 0
    
    var result = "0" //nhan ket qua tra ve tu service them vao tu phim
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        if let rel = self.revealViewController()
        {
            self.view.addGestureRecognizer(rel.panGestureRecognizer())
        }

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "icon_back_50"),
            style: .plain,
            target: self,
            action: #selector(leftBarButtonItem_click)
        )
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        title = "Thông tin phim"
    }

    func leftBarButtonItem_click()
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if viewStyle == 0
        {
            let vc = sb.instantiateViewController(withIdentifier: "vcMain") as! mainTableViewController
            let vcNav = UINavigationController.init(rootViewController: vc)
            self.revealViewController().pushFrontViewController(vcNav, animated: true)
        }
        
        if viewStyle == 1
        {
            let vc = sb.instantiateViewController(withIdentifier: "vcList") as! listViewController
            vc.viewStyle = 1
            vc.f_CallService(type: type, vaue: val)
            let vcNav = UINavigationController.init(rootViewController: vc)
            self.revealViewController().pushFrontViewController(vcNav, animated: true)
        }
        
        if viewStyle == 2
        {
            let vc = sb.instantiateViewController(withIdentifier: "vcList") as! listViewController
            
            vc.viewStyle = 2
            vc.f_SearchService(keyword: keyword, theloai: theloai, loaiphim: loaiphim, nam: nam, fansub: fansub)
            
            let navigationView = UINavigationController.init(rootViewController: vc)
            self.revealViewController().pushFrontViewController(navigationView, animated: true)
        }
        
        if viewStyle == 3
        {
            let vc = sb.instantiateViewController(withIdentifier: "vcRank") as! rankdetailTableViewController
            vc.f_CallService(loai: String(type))
            let navigationView = UINavigationController.init(rootViewController: vc)
            self.revealViewController().pushFrontViewController(navigationView, animated: true)
        }
        
        if viewStyle == 4
        {
            let vc = sb.instantiateViewController(withIdentifier: "vcWhs") as! whsTableViewController
            vc.f_CallService()
            let navigationView = UINavigationController.init(rootViewController: vc)
            self.revealViewController().pushFrontViewController(navigationView, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func CallService_LoadData(id :String) {
        
        idPhim = id
        let url: String = "http://ioswservice.somee.com/api/phim/chitiet/\(id)"
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let tk = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                print("1: \(error.debugDescription)")
            }
            else {
                do {
                    self.item = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : AnyObject]
                    
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                        self.f_Complete(item: self.item)
                    }
                    
                }
                catch let err as NSError {
                    print("2: \(err)")
                }
            }
        }
        
        tk.resume()
        
    }

    func f_Complete(item : [String : AnyObject])
    {
        imgBigImageView.showImgFrom(link: item["Hinh2"] as! String, contentMode: .scaleToFill)
        imgSmlImageView.showImgFrom(link: item["Hinh1"] as! String, contentMode: .scaleToFill)
        
        tenLabel.text = item["Ten"] as? String
        theLoaiLabel.text = item["Fansub"] as? String //"Hành động, Hài hước"
        nsxLable.text = item["NSX"] as? String //"Mad House"
        fansubLabel.text = item["TheLoai"] as? String //"FireGodPhoenix"
        
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        
        let sotap = item["SoTap"] is NSNull || item["SoTap"] as! Int == 0 ? "??" : String(item["SoTap"] as! Int)
        let sotaphienco = String(item["SoTapHienCo"] as! Int)
        let luotxem = item["SoLuotXem"] as! NSNumber
        let yeuthich = item["SoLuotThich"] as! Int
        
        var lx: String = ""
        lx = numberFormatter.string(from: luotxem)!
        
        sotapLabel.text = "\(sotaphienco)/\(sotap) tập"
        uotxemLabel.text = "\(lx) lượt"
        favoLabel.text = String(yeuthich)
        timeLabel.text = "\(item["ThoiLuong"] as! Int) phút"
        yearLabel.text = String(item["NamPhatHanh"] as! Int)
    }
    
    @IBAction func watchButton_Click(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcFansub") as! fansubViewController
        vc.id = idPhim
        vc.CallService()
        let vcNav = UINavigationController.init(rootViewController: vc)
        self.revealViewController().pushFrontViewController(vcNav, animated: true)
        
    }
    
    @IBAction func addWhsButton_Click(_ sender: Any) {
        
        let isLogin = UserDefaults.standard.bool(forKey: "isLogin")
        
        if isLogin
        {
            let dict = UserDefaults.standard.value(forKey: "dict") as! [String: AnyObject]
            let id = dict["MaTK"] as! Int
            f_CallService_Add(taikhoan: id)
        }
        else
        {
            f_ShowAlert_OK(title: "Thông báo", mess: "Vui lòng đăng nhập để sử dụng chức năng này !")
        }
    }
    
    func f_CallService_Add(taikhoan: Int)
    {
        let url: String = "http://ioswservice.somee.com/api/Phim/addtuphim"
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "POST"
        
        let postString = "taikhoan=\(taikhoan)&maphim=\(idPhim)"
        
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
                        
                        if self.result == "1"
                        {
                            self.f_ShowAlert_OK(title: "Thông báo", mess: "Đã thêm vào tủ phim của bạn")
                        }
                        else if self.result == "-1"
                        {
                            self.f_ShowAlert_OK(title: "Thông báo", mess: "Phim đã có trong tủ phim của bạn !")
                        }
                        else
                        {
                            self.f_ShowAlert_OK(title: "Thông báo", mess: "Phim không thể thêm vào tủ phim")
                        }
                    }
                    
                }
                catch let err as NSError {
                    print("2 : \(err)")
                    
                    self.f_ShowAlert_OK(title: "Thông báo", mess: "Lỗi xử lý! Vui lòng thử lại sau.")
                }
            }
        }
        
        tk.resume()

    }
    // MARK: - Table view data source

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
