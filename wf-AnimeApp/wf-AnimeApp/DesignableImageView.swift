//
//  DesignableImageView.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/10/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableImageView: UIImageView {

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
}
