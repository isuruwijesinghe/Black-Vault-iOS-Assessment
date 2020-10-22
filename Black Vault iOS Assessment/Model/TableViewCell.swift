//
//  TableViewCell.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/22/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var JobsTimeView: UILabel!
    @IBOutlet weak var JobsDistanceView: UILabel!
    @IBOutlet weak var JobsRateView: UILabel!
    @IBOutlet weak var JobsImageView: UIImageView!
    @IBOutlet weak var JobNameView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
