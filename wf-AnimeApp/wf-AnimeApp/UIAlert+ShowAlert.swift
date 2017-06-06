//
//  UIAlert+ShowAlert.swift
//  wf-GIuaKy
//
//  Created by Thanh Nam on 4/23/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit
import Foundation

protocol AlertDelegate : class
{
    func f_Handel_YES()
    func f_Handel_NO()
    func f_Handel_OK()
}

protocol AlertTextDelegate : class
{
    func f_Handel_ADD(value: String, qty : Int)
}

extension UIViewController {

    func f_ShowAlert_YESNO(title: String, mess: String, delegate: AlertDelegate?)
    {
        let alertController = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        let alertActionNO = UIAlertAction(title: "NO", style: .default, handler: {
            action in
            delegate?.f_Handel_NO()
        })
        alertController.addAction(alertActionNO)
        let alertActionYES = UIAlertAction(title: "YES", style: .default, handler: {
            action in
            delegate?.f_Handel_YES()
        })
        alertController.addAction(alertActionYES)
        present(alertController, animated: true, completion: nil)
    }
    
    func f_ShowAlert_OK(title: String, mess: String, delegate: AlertDelegate?)
    {
        let alertController = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        let alertActionYES = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            delegate?.f_Handel_OK()
        })
        alertController.addAction(alertActionYES)
        present(alertController, animated: true, completion: nil)
    }
    
    func f_ShowAlert_OK(title: String, mess: String)
    {
        let alertController = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        let alertActionYES = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertActionYES)
        present(alertController, animated: true, completion: nil)
    }
    
    func f_ShowAlert_Text_2(title: String, mess: String, delegate: AlertTextDelegate?, enabal: Bool, value :String)
    {
        let alertController = UIAlertController(title: title, message: mess, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Number table"
            if enabal == false {
                textField.text = value
                textField.isUserInteractionEnabled = enabal
            }
            else {
                textField.becomeFirstResponder()
            }
        })
        
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Quantity"
            if enabal == false {
                textField.becomeFirstResponder()
            }

        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancel)
        let alertActionYES = UIAlertAction(title: "ADD", style: .default, handler: {
            action in
            let id = alertController.textFields?[0]
            let qty = alertController.textFields?[1]
            
            if id?.text == "" || qty?.text == "" {
                delegate?.f_Handel_ADD(value: "", qty: 0)
            }
            else {
                delegate?.f_Handel_ADD(value: (id?.text!)!, qty: Int((qty?.text)!)!)
            }
        })
        alertController.addAction(alertActionYES)
        present(alertController, animated: true, completion: nil)
    }
    

}


