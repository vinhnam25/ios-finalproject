//
//  customTableViewCell.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/13/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
