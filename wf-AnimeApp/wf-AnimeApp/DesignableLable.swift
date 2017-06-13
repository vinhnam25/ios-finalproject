//
//  DesignableLable.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/6/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableLable: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderBottom : CGFloat = 0 {
        didSet {
            let border = CALayer()
            border.backgroundColor = tintColor?.cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - borderBottom, width: frame.size.width, height: borderBottom)
            self.layer.addSublayer(border)
        }
    }
    
    @IBInspectable var iconLabel : UIImage? {
        didSet {
            let attachment = NSTextAttachment()
            attachment.image = iconLabel
            attachment.bounds = CGRect(x: -3, y: -3, width: 20, height: 20)
            let attachmentStr = NSAttributedString(attachment: attachment)
            let myString = NSMutableAttributedString(string: "")
            myString.append(attachmentStr)
            let myString1 = NSMutableAttributedString(string: self.text!)
            myString.append(myString1)
            self.attributedText = myString
            
        }
    }
}
