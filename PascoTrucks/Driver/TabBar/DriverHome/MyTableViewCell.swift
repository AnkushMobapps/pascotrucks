//
//  MyTableViewCell.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 17/04/24.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
@IBOutlet weak var cellView: UIView!
@IBOutlet weak var clientImg: UIImageView!
@IBOutlet weak var clientName: UILabel!
@IBOutlet weak var ratingImg: UIImageView!
@IBOutlet weak var ratingPoints: UILabel!
@IBOutlet weak var pickupPoint: UILabel!
@IBOutlet weak var dropPoint: UILabel!
@IBOutlet weak var price: UILabel!
@IBOutlet weak var clientOrderId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    /*    cellView.layer.cornerRadius = 20
        cellView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        cellView.layer.shadowOpacity = 0.5
        cellView.layer.shadowRadius = 10
        cellView.layer.shadowOffset =  CGSize(width: 4, height: 4)
        cellView.layer.masksToBounds = false*/
        cellView.layer.cornerRadius = 20
        cellView.layer.borderWidth = 0
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cellView.layer.shadowRadius = 2
        cellView.layer.shadowOpacity = 0.3
        cellView.layer.masksToBounds = false
    }
}


