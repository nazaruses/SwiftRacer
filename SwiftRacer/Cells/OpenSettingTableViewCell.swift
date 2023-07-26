//
//  OpenSettingTableViewCell.swift
//  SwiftRacer
//
//  Created by Nazar Dremach on 22/7/23.
//

import UIKit

class OpenSettingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var settingName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
