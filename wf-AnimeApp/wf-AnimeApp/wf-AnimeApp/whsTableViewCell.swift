//
//  whsTableViewCell.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/14/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class whsTableViewCell: UITableViewCell {

    @IBOutlet weak var hinh: DesignableImageView!
    @IBOutlet weak var tap: UILabel!
    @IBOutlet weak var ten: UILabel!
    @IBOutlet weak var luotxem: DesignableLable!
    @IBOutlet weak var danhgia: DesignableLable!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
