//
//  DriverEmergencyCell.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 18/06/24.
//

import UIKit

class DriverEmergencyCell: UITableViewCell {

    
    @IBOutlet weak var callingButton: UIButton!
    
    var callingBtn:(()->())!
    
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var emergencyNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    @IBAction func callingBtnClk(_ sender: UIButton) {
        callingBtn()
    }
    
}
