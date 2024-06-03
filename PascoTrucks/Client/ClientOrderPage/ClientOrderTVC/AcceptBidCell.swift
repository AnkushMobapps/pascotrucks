//
//  AcceptBidCell.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 16/05/24.
//

import UIKit

class AcceptBidCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var estimatePrizeLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var NextBtn: UIButton!
    var nextButton:(()->()) = {}
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        mainView.layer.borderWidth = 0
//        mainView.layer.shadowColor = UIColor.black.cgColor
//        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        mainView.layer.shadowRadius = 2
//        mainView.layer.shadowOpacity = 0.3
//        mainView.layer.masksToBounds = false
    }

    @IBAction func nextBtnTapped(_ sender: UIButton) {
        nextButton()
        
    }

}
