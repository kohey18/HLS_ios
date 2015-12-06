//
//  ProgramTableViewCell.swift
//  GNChannel
//
//  Created by kohey on 2015/11/23.
//  Copyright © 2015年 kohey. All rights reserved.
//

import UIKit

class ProgramTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var programName: UILabel!
    @IBOutlet weak var programUserName: UILabel!
    @IBOutlet weak var programDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.programName.textColor = UIColor.whiteColor()
        self.programUserName.textColor = UIColor.whiteColor()
                
        self.programDesc.textColor = UIColor.whiteColor()
        self.programDesc.numberOfLines = 0
        self.programDesc.sizeToFit()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
