//
//  loginViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/5/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class loginViewController: UIViewController, AlertOKDelegate {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var loginBar: UINavigationBar!
    
    @IBOutlet weak var usernameTextField: DesignableTextField!
    @IBOutlet weak var passTextField: DesignableTextField!
    
    var result: [String : AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bgImageView.image = #imageLiteral(resourceName: "bg_login")
        self.navigationItem.title = "Đăng nhập"
        
        passTextField.isSecureTextEntry = true
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.loginBar.setBackgroundImage(UIImage(), for: .default)
        self.loginBar.shadowImage = UIImage()
        self.loginBar.isTranslucent = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton_click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButton(_ sender: Any) {

        if f_ValidateAll() == true {
            let url: String = "http://ioswservice.somee.com/api/TaiKhoan/Login"
            
            var urlRequest = URLRequest(url: URL(string: url)!)
            urlRequest.httpMethod = "POST"
            
            let postString = "username=\(usernameTextField.text!)&password=\(passTextField.text!)"
            
            urlRequest.httpBody = postString.data(using: .utf8)
            
            let tk = URLSession.shared.dataTask(with: urlRequest)
            {
                (data, response, error) in
                if error != nil {
                    print(error.debugDescription)
                }
                else {
                    
                    do {
                        self.result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
                        
                        OperationQueue.main.addOperation {
                            
                            if self.result.isEmpty
                            {
                                self.f_ShowAlert_OK(title: "Thông báo", mess: "Đăng nhập thất bại !")
                            }
                            else{
                                let matk = self.result["MaTK"] as! Int
                                
                                if matk > 0 {
                                    
                                    UserDefaults.standard.set(self.result, forKey: "dict")
                                    UserDefaults.standard.set(true, forKey: "isLogin")

                                    self.f_ShowAlert_OK(title: "Thông báo", mess: "Đăng nhập thành công.", delegate: self)
                                }
                                else
                                {
                                    self.f_ShowAlert_OK(title: "Thông báo", mess: "Sai tên đăng nhập hoặc mật khẩu !")
                                }
                                print(self.result)
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
    
    func f_ValidateAll() -> Bool
    {
        if usernameTextField.text! == ""
        {
            f_ShowAlert_OK(title: "Lỗi", mess: "Chưa nhập tên đăng nhập !")
            return false
        }
        
        if passTextField.text! == ""
        {
            f_ShowAlert_OK(title: "Lỗi", mess: "Chưa nhập mật khẩu !")
            return false
        }
        
        return true
    }
    
    func f_Handel_OK() {
        dismiss(animated: true, completion: nil)
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
