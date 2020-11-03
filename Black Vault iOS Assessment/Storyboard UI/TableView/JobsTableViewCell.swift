//
//  JobsTableViewCell.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/16/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class JobsTableViewCell: UITableViewCell {

    @IBOutlet weak var Cell_JobsImageView: UIImageView!
    @IBOutlet weak var Cell_JobsDistanceLabel: UILabel!
    @IBOutlet weak var Cell_JobsNameLabel: UILabel!
    @IBOutlet weak var Cell_JobsTimeLabel: UILabel!
    @IBOutlet weak var Cell_JobsRateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
