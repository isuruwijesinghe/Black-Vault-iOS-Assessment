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
        
        self.JobsImageView.layer.masksToBounds = true
        self.JobsImageView.layer.cornerRadius = self.JobsImageView.frame.width/19.0
        
        JobsRateView?.layer.masksToBounds = true
//        JobsRateView?.layer.cornerRadius = 20.0
//        JobsRateView?.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        //MARK:- Corner Radius of only two side of UIViews
        self.roundCorners(view: JobsRateView, corners: [.topLeft], radius: 10.0)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Corner Radius of only two side of UIViews
    func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
            let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            view.layer.mask = mask
    }

}
