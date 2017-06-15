//
//  quanlyPhimTableViewController.swift
//  wf-AnimeApp
//
//  Created by Nam Tran 6/12/17.
//  Copyright © 2017 Nam Tran. All rights reserved.
//

import UIKit

class quanlyPhimTableViewController: UITableViewController {
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
        let vc = sb.instantiateViewController(withIdentifier: "editPhim") as! themPhimTableViewController
        vc.isEdit = true
        var id: String = "0"
        let list = sectionData[indexPath.section]!
        id = String(list[indexPath.row]["ID"] as! Int)
        vc.getPhim(id:id)
        self.show(vc, sender: nil)
    }
    
    @IBAction func unwindToQuanLyPhim(segue:UIStoryboardSegue) {
        
    }
}

class themPhimTableViewController: UITableViewController {
    @IBOutlet var previewImage: UIImageView!
    @IBOutlet var smallImage: UITextField!
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
    @IBOutlet var fansub: UITextField!
    
    var result : String = "0"
    var isEdit : Bool = false
    //var phim : Phim!
    var item = [String : AnyObject]()
    
    @IBAction func textFieldEditingDidEnd(sender: AnyObject) {
        print("editing...")
        loadImageFromUrl(url: smallImage.text!, view: previewImage)
    }
    
    func loadImageFromUrl(url: String, view: UIImageView){
        
        let url = NSURL(string: url)!
        
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
    
    func getPhim(id :String) {
        print("sửa phim " + id)
        title = "Cập nhật phim"
        
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
                        self.f_FillData(item: self.item)
                    }
                    
                }
                catch let err as NSError {
                    print("2: \(err)")
                }
            }
        }
        
        tk.resume()
    }
    
    func f_FillData(item : [String : AnyObject])
    {
        smallImage.text = item["Hinh1"] as? String
        bigImage.text = item["Hinh2"] as? String
        tenPhim.text = item["Ten"] as? String
        loai.text = item["TheLoai"] as? String //"Hành động, Hài hước"
        nsx.text = item["NSX"] as? String //"Mad House"
        fansub.text = item["Fansub"] as? String //"FireGodPhoenix"
        moTaPhim.text = item["MoTaPhim"] as? String
        tinhTrang.text = item["TinhTrang"] as? String
        
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        
        let sotap = item["SoTap"] is NSNull || item["SoTap"] as! Int == 0 ? "??" : String(item["SoTap"] as! Int)
        let sotaphienco = String(item["SoTapHienCo"] as! Int)
        //let luotxem = item["SoLuotXem"] as! NSNumber
        //let yeuthich = item["SoLuotThich"] as! Int
        
        //var lx: String = ""
        //lx = numberFormatter.string(from: luotxem)!
        
        soTap.text = sotaphienco
        soTapHienCo.text = "\(sotap) tập"
        //luotxemLabel.text = "\(lx) lượt"
        //favoLabel.text = String(yeuthich)
        thoiLuong.text = "\(item["ThoiLuong"] as! Int) phút"
        namPhatHanh.text = String(item["NamPhatHanh"] as! Int)
    }
    
    func luuPhim(){
        if(!isEdit)
        {
            let url: String = "http://ioswservice.somee.com/api/Phim/Them"
            
            var urlRequest = URLRequest(url: URL(string: url)!)
            urlRequest.httpMethod = "POST"
            
            let currentdate = Date()
            
            let postString = "ten=\(tenPhim.text!)&NhaSX=\(nsx.text!)&SoTap=\(soTap.text!)&SoTapHienCo=\(soTapHienCo.text!)&ThoiLuong=\(thoiLuong.text!)&NamPhatHanh=\(namPhatHanh.text!)&TinhTrangPhim=\(tinhTrang.text)&MoTaPhim=\(moTaPhim.text!)&LoaiPhim=\(loai.text!)&Hinh1=\(smallImage.text!)&Hinh2=\(bigImage.text!)&SoLuotXem=nil&SoLuoThich=nil&XepHang=nil&DiemDanhGia=nil&UpdateDate=\(currentdate)"
            
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
        else {
            let url: String = "http://ioswservice.somee.com/api/Phim/CapNhat"
            
            var urlRequest = URLRequest(url: URL(string: url)!)
            urlRequest.httpMethod = "POST"
            
            let currentdate = Date()
            
            let postString = "ten=\(tenPhim.text!)&NhaSX=\(nsx.text!)&SoTap=\(soTap.text!)&SoTapHienCo=\(soTapHienCo.text!)&ThoiLuong=\(thoiLuong.text!)&NamPhatHanh=\(namPhatHanh.text!)&TinhTrangPhim=\(tinhTrang.text)&MoTaPhim=\(moTaPhim.text!)&LoaiPhim=\(loai.text!)&Hinh1=\(smallImage.text!)&Hinh2=\(bigImage.text!)&SoLuotXem=nil&SoLuoThich=nil&XepHang=nil&DiemDanhGia=nil&UpdateDate=\(currentdate)"
            
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
                                self.f_ShowAlert_OK(title: "Thông báo", mess: "Cập nhật phim thành công.")
                            }
                            else{
                                self.f_ShowAlert_OK(title: "Thông báo", mess: "Không cập nhật được phim!")
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


