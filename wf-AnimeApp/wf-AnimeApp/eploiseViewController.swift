//
//  eploiseViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/10/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer

class eploiseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var epTableView: UITableView!
    @IBOutlet weak var filterTextField: DesignableTextField!
    
    var result: [[String : AnyObject]] = [[:]]
    var respone: [[String : AnyObject]] = [[:]]
    var temp: [[String : AnyObject]] = [[:]]
    
    var id: String = "0"
    var nhomdich = "0"
    var tennhomdich = ""
    var quality = ""
    var noData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Chọn tập xem"
        
        if let reveal = self.revealViewController() {
            self.view.addGestureRecognizer(reveal.panGestureRecognizer())
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "icon_back_50"),
            style: .plain,
            target: self,
            action: #selector(leftBarButtonItem_click)
        )
        
    }

    func leftBarButtonItem_click() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "vcFansub") as! fansubViewController
        vc.id = id
        vc.CallService()
        let vcNav = UINavigationController.init(rootViewController: vc)
        self.revealViewController().pushFrontViewController(vcNav, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func f_CallService(id: String, fansub: String, quality: String)
    {
        
        self.id = id
        self.nhomdich = fansub
        self.quality = quality
        
        let url: String = "http://ioswservice.somee.com/api/Phim/dstap"
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "POST"
        
        let postString = "MaPhim=\(id)&NhomDich=\(fansub)&Quality=\(quality)"
        
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
                    
                    self.result = self.respone
                    
                    OperationQueue.main.addOperation {
                        self.epTableView.reloadData()
                    }
                    
                }
                catch let err as NSError {
                    print(err)
                    self.noData = true
                    
                    OperationQueue.main.addOperation {
                        self.epTableView.reloadData()
                    }
                    
                }
            }
        }
        
        tk.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if result.isEmpty
        {
            return 0
        }
        else
        {
            return result.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellEp", for: indexPath) as! eploiseTableViewCell
        
        let item = result[indexPath.row]
        
        if let soTap = item["TapPhim"]
        {
            let valueCell = "Tập \(String(soTap as! Int))"
            cell.soTapLabel.text = valueCell
        }
        else{
            cell.soTapLabel.text = "Loading..."
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x:0, y:0, width: tableView.frame.size.width, height: 18))
        let label = UILabel(frame: CGRect(x:45, y:15, width:tableView.frame.size.width, height:18))
        label.font = UIFont.systemFont(ofSize: 20)
        
        if(noData)
        {
            label.text = "Không lấy được thông tin"
        }
        else
        {
            label.text = tennhomdich
        }
        
        view.addSubview(label)
        view.backgroundColor = UIColor.cyan // Set your background color
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    @IBAction func filter_EditChanged(_ sender: Any) {

        let value = filterTextField.text!
        if value != ""
        {
            temp.removeAll()
            for item in respone
            {
                if let soTap = item["TapPhim"]
                {
                    let val = String(soTap as! Int)
                    if val.contains(value)
                    {
                        temp.append(item)
                    }
                }
            
            }
        
            result = temp
        }
        else{
            result = respone
        }
        epTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pathVideo = result[indexPath.row]["LinkStream"] as! String
        let videoURL = URL(string: pathVideo)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
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
