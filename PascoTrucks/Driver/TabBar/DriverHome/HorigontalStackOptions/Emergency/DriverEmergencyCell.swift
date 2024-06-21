//
//  DriverEmergencyCell.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 18/06/24.
//

import UIKit

class DriverEmergencyCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    var driverId:Int?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkImage.image = #imageLiteral(resourceName: "sqaure")
        mainView.layer.borderWidth = 0
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowRadius = 2
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.masksToBounds = false
    }
    
}
