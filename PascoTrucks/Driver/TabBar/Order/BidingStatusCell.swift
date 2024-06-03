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
        // Initialization code
    }

 
    
    @IBAction func nextBtnClk(_ sender: UIButton) {
        nextButton()
    }
    
}
