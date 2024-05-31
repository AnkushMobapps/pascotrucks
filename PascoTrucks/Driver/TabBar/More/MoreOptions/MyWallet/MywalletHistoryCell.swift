//
//  MywalletHistoryCell.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 25/05/24.
//

import UIKit

class MywalletHistoryCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.borderWidth = 0
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowRadius = 2
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.masksToBounds = false // Initialization code
    }

    
    
}
