//
//  firstTableViewCell.swift
//  AutoLayout
//
//  Created by JohnLui on 15/3/22.
//  Copyright (c) 2015年 Miao Tec Inc. All rights reserved.
//

import UIKit

class firstTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
