//
//  EmergencyContactsCell.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 20/06/24.
//

import UIKit

class EmergencyContactsCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var emergencyNumber: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        mainView.layer.borderWidth = 0
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowRadius = 2
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.masksToBounds = false
    }

  
}
