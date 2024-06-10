//
//  GetOrderFromClientCell.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 05/06/24.
//

import UIKit

class GetOrderFromClientCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var clientImg: UIImageView!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var ratingImg: UIImageView!
    @IBOutlet weak var ratingPoints: UILabel!
    @IBOutlet weak var pickupPoint: UILabel!
    @IBOutlet weak var dropPoint: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var clientOrderId: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!
    
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
