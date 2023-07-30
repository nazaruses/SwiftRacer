//
//  StatisticsTableViewCell.swift
//  Swift Racer
//
//  Created by Nazar Dremach on 30/7/23.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePlayer: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var points: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
