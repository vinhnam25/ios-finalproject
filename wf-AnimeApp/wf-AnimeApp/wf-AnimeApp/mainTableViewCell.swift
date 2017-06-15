//
//  mainTableViewCell.swift
//  wf-AnimeApp
//
//  Created by Thanh Nam on 6/4/17.
//  Copyright © 2017 Thanh Nam. All rights reserved.
//

import UIKit

class mainTableViewCell: UITableViewCell {

    @IBOutlet weak var ShowImageView: UIImageView!
    @IBOutlet weak var NameLable: UILabel!
    @IBOutlet weak var SoTapLable: UILabel!
    @IBOutlet weak var LuotXemLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
