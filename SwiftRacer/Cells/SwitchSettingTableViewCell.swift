//
//  SwitchSettingTableViewCell.swift
//  SwiftRacer
//
//  Created by Nazar Dremach on 22/7/23.
//

import UIKit

class SwitchSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet weak var settingName: UILabel!
    
    weak var delegate: SwitchSettingDelegate?
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func switchChanged(_ sender: Any) {
        delegate?.cell(self, changeValueTo: `switch`.isOn)
    }
    
}

protocol SwitchSettingDelegate: AnyObject {
        func cell(_ cell: SwitchSettingTableViewCell, changeValueTo isOn: Bool)
}
