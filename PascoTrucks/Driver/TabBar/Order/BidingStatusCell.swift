//
//  BidingStatusCell.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 03/06/24.
//

import UIKit

class BidingStatusCell: UITableViewCell {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var mainView: UIView!
   
    @IBOutlet weak var nextBtn: UIButton!
    var nextButton:(()->())!
    
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
