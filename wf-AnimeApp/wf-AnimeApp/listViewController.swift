//
//  listViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/13/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class listViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var dataCollection: UICollectionView!
    @IBOutlet weak var nameFilterTextField: DesignableTextField!
    
    
    var list : [[String: AnyObject]] = [[:]]
    var respone : [[String: AnyObject]] = [[:]]
    var temp : [[String: AnyObject]] = [[:]]
    var isError = false
    var type = 0
    var value = 0
    var viewStyle = 0
    
    var keyword = ""
    var theloai = 0
    var loaiphim = 0
    var nam = 0
    var fansub = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let rel = self.revealViewController()
        {
            self.view.addGestureRecognizer(rel.panGestureRecognizer())
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "icon_back_50"),
            style: .plain,
            target: self,
            action: #selector(leftBarButtonItem_click)
        )
        
        title = "Danh sách"
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
    
    func leftBarButtonItem_click()
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if viewStyle == 0
        {
            let vc = sb.instantiateViewController(withIdentifier: "vcCustom") as! customViewController
            self.revealViewController().pushFrontViewController(vc, animated: true)
        }
        
        if viewStyle == 1
        {
            let vc1 = sb.instantiateViewController(withIdentifier: "vcReposi") as! reposiTableViewController
            vc1.f_callService(type: type)
            let navigationView1 = UINavigationController.init(rootViewController: vc1)
            self.revealViewController().pushFrontViewController(navigationView1, animated: true)
        }
        
        if viewStyle == 2
        {
            let vc1 = sb.instantiateViewController(withIdentifier: "vcFilter") as! filterTableViewController
            let navigationView1 = UINavigationController.init(rootViewController: vc1)
            self.revealViewController().pushFrontViewController(navigationView1, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func f_CallService(type : Int , vaue : Int)
    {
        setLoading()
        
        self.type = type
        value = vaue
        let url: String = "http://ioswservice.somee.com/api/Phim/getbytype"
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "POST"
        
        let postString = "type=\(type)&value=\(vaue)"
        
        urlRequest.httpBody = postString.data(using: .utf8)
        
        let tk = URLSession.shared.dataTask(with: urlRequest)
        {
            (data, response, error) in
            if error != nil {
                print(error.debugDescription)
            }
            else {

                do {
                    self.respone = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    
                    self.list = self.respone
                    
                    OperationQueue.main.addOperation {
                        self.viewIndicator.isHidden = true
                        self.dataCollection.reloadData()
                    }
                    
                }
                catch let err as NSError {
                    print(err)
                    self.isError = true
                    
                    OperationQueue.main.addOperation {
                        self.viewIndicator.isHidden = true
                        self.dataCollection.reloadData()
                    }
                    
                }
            }
        }
        
        tk.resume()

        
    }
    
    func f_SearchService(keyword: String, theloai : Int , loaiphim : Int, nam: Int, fansub: Int)
    {
        setLoading()
        
        self.keyword = keyword
        self.theloai = theloai
        self.loaiphim = loaiphim
        self.nam = nam
        self.fansub = fansub
        
        let url: String = "http://ioswservice.somee.com/api/Phim/timkiem"
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "POST"
        
        let postString = "keyword=\(keyword)&theloai=\(theloai)&fansub=\(fansub)&nam=\(nam)&loaiphim=\(loaiphim)"
        print(postString)
        
        urlRequest.httpBody = postString.data(using: .utf8)

        let tk = URLSession.shared.dataTask(with: urlRequest)
        {
            (data, response, error) in
            if error != nil {
                print("1: \(error.debugDescription)")
            }
            else {
                
                do {
                    self.respone = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    
                    self.list = self.respone
                    
                    OperationQueue.main.addOperation {
                        self.viewIndicator.isHidden = true
                        self.dataCollection.reloadData()
                    }
                    
                }
                catch let err as NSError {
                    print("2 : \(err)")
                    self.isError = true
                    
                    OperationQueue.main.addOperation {
                        self.viewIndicator.isHidden = true
                        self.dataCollection.reloadData()
                    }
                    
                }
            }
        }
        
        tk.resume()
        
    }
    

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isError
        {
            return 0
        }
        
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell0", for: indexPath) as! listCollectionViewCell
        
        let item = list[indexPath.row]
        
        var sotap = ""
        var sotapall = ""
        var ten = ""
        
        if item["Hinh1"] != nil
        {
            let hinh = item["Hinh1"] as? String
            cell.smImageView.showImgFrom(link: hinh!, contentMode: .scaleToFill)
        }
        
        if item["Ten"] != nil
        {
            ten = (item["Ten"] as? String)!
            cell.nameLabel.text = ten
        }
        else
        {
            cell.nameLabel.text = "Loading..."
        }
        
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
        
        cell.epLabel.text = "\(sotap)/\(sotapall)"
        
        return cell
    }
    
    @IBAction func namFilter_EditChanged(_ sender: Any) {
        
        let value = nameFilterTextField.text!
        if value != ""
        {
            temp.removeAll()
            for item in respone
            {
                if let ten = item["Ten"]
                {
                    let val = ten as! String
                    if val.lowercased().contains(value.lowercased())
                    {
                        temp.append(item)
                    }
                }
                
            }
            
            list = temp
        }
        else{
            list = respone
        }
        dataCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcDetail") as! detailTableViewController
        vc.type = type
        vc.val = value
        vc.viewStyle = self.viewStyle == 2 ? 2 : 1
        
        if self.viewStyle == 2
        {
            vc.keyword = keyword
            vc.theloai = theloai
            vc.loaiphim = loaiphim
            vc.nam = nam
            vc.fansub = fansub
        }
        
        let item = list[indexPath.row]
        
        if item["ID"] is NSNull || item["ID"] == nil
        {
            return
        }
        
        let maPhim = item["ID"] as! Int
        vc.CallService_LoadData(id: String(maPhim))
        
        let navigationView = UINavigationController.init(rootViewController: vc)
        self.revealViewController().pushFrontViewController(navigationView, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "section", for: indexPath) as! listCollectionReusableView
        
        let count = list.count
        
        if isError
        {
            sectionHeader.alertLabel.text = "Không có dữ liệu"
        }
        else {
            sectionHeader.alertLabel.text = "Danh sách có \(count) bộ phim"
        }
        
        return sectionHeader

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
