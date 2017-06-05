//
//  menuViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/4/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class menuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var menuDict = [
        "cell1" : "Trang chủ",
        "cell2" : "Xem danh sách phim",
        "cell3" : "Lọc phim",
        "cell4" : "Lịch chiếu",
        "cell5" : "Bảng xếp hạng"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let key = Array(menuDict.keys).sorted{$0.0 < $0.1}[indexPath.row]
        let cellContent = tableView.dequeueReusableCell(withIdentifier: key, for: indexPath)
        cellContent.textLabel?.text = menuDict[key]
        
        return cellContent
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
