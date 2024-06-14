//
//  DriverCompletedOrderCell.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 12/06/24.
//

import UIKit

class DriverCompletedOrderCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var clientName: UILabel!
    
    @IBOutlet weak var completetedAt: UILabel!
    
    @IBOutlet weak var orderIdTxt: UILabel!
    
    @IBOutlet weak var pickupTxt: UILabel!
    
    @IBOutlet weak var dropTxt: UILabel!
    
    @IBOutlet weak var priceTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 20
        mainView.layer.borderWidth = 0
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainView.layer.shadowRadius = 2
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.masksToBounds = false
    }

  
    
}
