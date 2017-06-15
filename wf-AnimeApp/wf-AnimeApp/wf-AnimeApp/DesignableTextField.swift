//
//  DesignableTextField.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/5/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var leftImage : UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding : CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = tintColor.cgColor
        }
    }
    
    func updateView()
    {
        
        if let image = leftImage {
            
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.image = image
            imageView.tintColor = tintColor
            
            var width = leftPadding + 20
            
            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
                width = width + 5
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            
            leftView = view
        }
        else {
            leftViewMode = .never
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSForegroundColorAttributeName : tintColor])
    }
    
    
}
