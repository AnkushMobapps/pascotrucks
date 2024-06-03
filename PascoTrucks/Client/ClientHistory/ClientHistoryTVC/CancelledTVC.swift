//
//  CancelledTVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 29/05/24.
//

import UIKit

class CancelledTVC: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var pickUpLocationLbl: UILabel!
    @IBOutlet weak var dropLocationLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var fianlCostLbl: UILabel!
    @IBOutlet weak var arrivalTimeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
