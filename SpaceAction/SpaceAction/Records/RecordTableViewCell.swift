//
//  RecordTableViewCell.swift
//  SpaceAction
//
//  Created by A on 4/14/22.
//

import UIKit

class RecordTableViewCell: UITableViewCell {


    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
