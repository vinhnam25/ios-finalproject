//
//  signupViewController.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/6/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class signupViewController: UIViewController {

    @IBOutlet weak var usernameTextField: DesignableTextField!
    @IBOutlet weak var passTextField: DesignableTextField!
    @IBOutlet weak var passcfTextFied: DesignableTextField!
    @IBOutlet weak var emailTextField: DesignableTextField!
    @IBOutlet weak var fullnameTextFileld: DesignableTextField!
    
    var result : String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        passTextField.isSecureTextEntry = true
        passcfTextFied.isSecureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        if(f_ValidateAll())
        {
            let url: String = "http://ioswservice.somee.com/api/TaiKhoan/Register"
            
            var urlRequest = URLRequest(url: URL(string: url)!)
            urlRequest.httpMethod = "POST"
            
            let postString = "username=\(usernameTextField.text!)&password=\(passTextField.text!)&email=\(emailTextField.text!)&hoten=\(fullnameTextFileld.text!)&permis=0"
            
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
                                self.f_ShowAlert_OK(title: "Thông báo", mess: "Tạo tài khoản thành công.")
                                self.usernameTextField.text! = ""
                                self.passTextField.text! = ""
                                self.passcfTextFied.text! = ""
                                self.emailTextField.text! = ""
                                self.fullnameTextFileld.text! = ""
                            }
                            else{
                                self.f_ShowAlert_OK(title: "Thông báo", mess: "Không tạo được tài khoản !")
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
            
            //f_ShowAlert_OK(title: "", mess: "Đang xử lý ...")
        }
    }

    @IBAction func loginButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
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
        
        if emailTextField.text! == ""
        {
            f_ShowAlert_OK(title: "Lỗi", mess: "Chưa nhập email !")
            return false
        }
        
        if fullnameTextFileld.text! == ""
        {
            f_ShowAlert_OK(title: "Lỗi", mess: "Chưa nhập họ tên !")
            return false
        }
        
        if passcfTextFied.text! != passTextField.text!
        {
            f_ShowAlert_OK(title: "Lỗi", mess: "Mật khẩu nhập lại không đúng !")
            return false
        }
        
        if isValidEmail(testStr: emailTextField.text!) == false
        {
            f_ShowAlert_OK(title: "Lỗi", mess: "Email không hợp lệ !")
            return false;
        }
        
        return true
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
