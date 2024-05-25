//
//  HistoryCell.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 24/04/24.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var viewOverImage: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var celltitle: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    var cancelButton:(()->())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    @IBAction func cancelBtnPress(_ sender: UIButton) {
        cancelButton()
    
    }
    

}
