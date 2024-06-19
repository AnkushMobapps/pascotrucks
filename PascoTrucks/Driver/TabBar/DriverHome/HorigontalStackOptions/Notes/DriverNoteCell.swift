//
//  DriverNoteCell.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 11/06/24.
//

import UIKit

class DriverNoteCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
     @IBOutlet weak var viewOverImg: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var noteimage: UIImageView!
    @IBOutlet weak var noteDescription: UILabel!
    @IBOutlet weak var deleteNotiBtn: UIButton!
    @IBOutlet weak var dateTime: UILabel!
    
    var notiFiId:Int!
    var deleteButton:(()->())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    @IBAction func deleteNotificationBtnClk(_ sender: UIButton) {
        deleteButton()
    }

}
