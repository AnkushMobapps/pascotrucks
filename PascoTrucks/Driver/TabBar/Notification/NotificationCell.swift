//
//  NotificationCell.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 24/04/24.
//

import UIKit

class NotificationCell: UITableViewCell {
    
@IBOutlet weak var mainView: UIView!
 @IBOutlet weak var viewOverImg: UIView!
@IBOutlet weak var notificationTitle: UILabel!
@IBOutlet weak var notificationImage: UIImageView!
@IBOutlet weak var notiDescription: UILabel!
@IBOutlet weak var deleteNotiBtn: UIButton!
@IBOutlet weak var dateTime: UILabel!
    var notiFiId:Int!
    var deleteButton:(()->())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        mainView.layer.borderWidth = 0
//        mainView.layer.shadowColor = UIColor.black.cgColor
//        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        mainView.layer.shadowRadius = 2
//        mainView.layer.shadowOpacity = 0.3
//        mainView.layer.masksToBounds = false
    }

  
    
    @IBAction func deleteNotificationBtnClk(_ sender: UIButton) {
        deleteButton()
    }
    
}
