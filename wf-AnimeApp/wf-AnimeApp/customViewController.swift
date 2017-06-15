//
//  customViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/13/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class customViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var arr = [
        ["Name":"Xem tất cả", "Type": "0"],
        ["Name":"Xem theo thể loại", "Type": "1"],
        ["Name":"Xem theo nhà sản xuất", "Type": "2"],
        ["Name":"Xem theo nhóm dịch", "Type": "3"],
    ]
    
    @IBOutlet weak var custableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.8)

        // Do any additional setup after loading the view.
        title = "Danh mục"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func f_GoToMenu(_ sender: Any) {
        self.revealViewController().revealToggle(sender)
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath) as! customTableViewCell
        
        cell.titleLabel.text = arr[indexPath.row]["Name"]
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        if indexPath.row > 0
        {
            let vc = sb.instantiateViewController(withIdentifier: "vcReposi") as! reposiTableViewController
            let type = Int(arr[indexPath.row]["Type"]!)
            vc.f_callService(type: type!)
            let navigationView = UINavigationController.init(rootViewController: vc)
            self.revealViewController().pushFrontViewController(navigationView, animated: true)
        }
        else
        {
            let vc1 = sb.instantiateViewController(withIdentifier: "vcList") as! listViewController
            vc1.f_CallService(type: 0, vaue: 0)        
            let navigationView1 = UINavigationController.init(rootViewController: vc1)
            self.revealViewController().pushFrontViewController(navigationView1, animated: true)
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
