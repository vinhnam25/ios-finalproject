//
//  quanlyPhimTableViewController.swift
//  wf-AnimeApp
//
//  Created by Nam Tran 6/12/17.
//  Copyright © 2017 Nam Tran. All rights reserved.
//

import UIKit

class quanlyPhimTableViewController: UITableViewController {
    @IBOutlet var tfURLImage: UITextField!
    @IBOutlet var previewImage: UIImageView!
    
    var list1 : [[String: AnyObject]] = [["Ten": "" as AnyObject, "SoLuotXem" : 0 as AnyObject, "SoTap": 0 as AnyObject, "Hinh1": "" as AnyObject, "SoTapHienCo": 0 as AnyObject]]
    
    let titles = [ "Danh sách phim"]
    var sectionData: [Int: [[String: AnyObject]]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionData = [0: self.list1]
        
        
        self.navigationItem.title = "Quản lý phim"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        f_GetAllPhim()
        //CallService2()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func f_ThemPhim()
    {
        //        let sb = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = sb.instantiateViewController(withIdentifier: "vcWhs") as! logoutViewController
        //        vc.modalTransitionStyle = .crossDissolve
        //        self.present(vc, animated: true, completion: nil)
    }
    
    func f_GetAllPhim() {
        
        let url: String = "http://ioswservice.somee.com/api/phim/GetAll"
        
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
                        //self.f_FinishService(index: 1)
                        print("get all phim")
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
        
        //let navigationView = UINavigationController.init(rootViewController: vc)
        //self.revealViewController().pushFrontViewController(navigationView, animated: true)
        //self.revealViewController().navigationController?.pushViewController(navigationView, animated: true)
    }
    
    @IBAction func unwindToQuanLyPhim(segue:UIStoryboardSegue) {
        
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

class themPhimTableViewController: UITableViewController {
    @IBOutlet var urlImage: UITextField!
    @IBOutlet var previewImage: UIImageView!
    @IBOutlet var bigImage: UITextField!
    @IBOutlet var tenPhim: UITextField!
    @IBOutlet var soTap: UITextField!
    @IBOutlet var soTapHienCo: UITextField!
    @IBOutlet var thoiLuong: UITextField!
    @IBOutlet var namPhatHanh: UITextField!
    @IBOutlet var moTaPhim: UITextField!
    @IBOutlet var nsx: UITextField!
    @IBOutlet var loai: UITextField!
    @IBOutlet var tinhTrang: UITextField!
    @IBOutlet var ngayPhatHanh: UITextField!
    
    var result : String = "0"
    
    @IBAction func textFieldEditingDidEnd(sender: AnyObject) {
        print("editing...")
        loadImageFromUrl(url: urlImage.text!, view: previewImage)
    }
    
    func loadImageFromUrl(url: String, view: UIImageView){
        
        // Create Url from string
        let url = NSURL(string: url)!
        
        // Download task:
        // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
        let task = URLSession.shared.dataTask(with: url as URL) { (responseData, responseUrl, error) -> Void in
            // if responseData is not null...
            if let data = responseData{
                
                // execute in UI thread
                DispatchQueue.main.async(execute: { () -> Void in
                    view.image = UIImage(data: data)
                })
            }
        }
        
        // Run task
        task.resume()
    }
    
    @IBAction func save(sender: AnyObject) {
        luuPhim()
        
        dismiss(animated: true, completion: nil)
    }
    
    func luuPhim(){
        if(true)
        {
            let url: String = "http://ioswservice.somee.com/api/Phim/Them"
            
            var urlRequest = URLRequest(url: URL(string: url)!)
            urlRequest.httpMethod = "POST"
            
            let currentdate = Date()
            
            let postString = "ten=\(tenPhim.text!)&NhaSX=\(nsx.text!)&SoTap=\(soTap.text!)&SoTapHienCo=\(soTapHienCo.text!)&ThoiLuong=\(thoiLuong.text!)&NamPhatHanh=\(namPhatHanh.text!)&TinhTrangPhim=\(tinhTrang.text)&MoTaPhim=\(moTaPhim.text!)&LoaiPhim=\(loai.text!)&Hinh1=\(urlImage.text!)&Hinh2=\(bigImage.text!)&SoLuotXem=nil&SoLuoThich=nil&XepHang=nil&DiemDanhGia=nil&UpdateDate=\(currentdate)"
            
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
                                self.f_ShowAlert_OK(title: "Thông báo", mess: "Thêm phim thành công.")
                            }
                            else{
                                self.f_ShowAlert_OK(title: "Thông báo", mess: "Không thêm được phim!")
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


