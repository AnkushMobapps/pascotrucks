//
//  GridCollectionCell.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 15/05/24.
//

import UIKit

class GridCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var imgName: UILabel!
    
    
    override func awakeFromNib() {
        mainView.layer.borderWidth = 0
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowRadius = 2
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.masksToBounds = false
    }
    
    
    
}
