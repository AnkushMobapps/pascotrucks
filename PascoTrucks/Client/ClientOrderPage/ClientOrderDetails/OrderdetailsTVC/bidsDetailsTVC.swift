//
//  bidsDetailsTVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 17/06/24.
//

import UIKit

class bidsDetailsTVC: UITableViewCell {

    @IBOutlet weak var dottedLineView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var pickupLocationLbl: UILabel!
    @IBOutlet weak var dropLocationLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var upfrontPaymentLbl: UILabel!
    @IBOutlet weak var estimatePriceLbl: UILabel!
    @IBOutlet weak var bidPriceLbl: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    
    var acceptedButton : (() -> ()) = {}
    var rejectButton : (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dottedLine()

        
    }
    
    
    func dottedLine(){
        let shapeLayer = CAShapeLayer()
//        shapeLayer.strokeColor = UIColor(red: 226/255, green: 68/255, blue: 132/255, alpha: 1.0).cgColor // Line color
        shapeLayer.strokeColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        shapeLayer.lineWidth = 2.0 // Line width
        shapeLayer.lineDashPattern = [12, 7] // [Dash length, Gap length]

        let path = CGMutablePath()
        let startPoint = CGPoint(x: 0, y: dottedLineView.frame.size.height / 2)
        let endPoint = CGPoint(x: dottedLineView.frame.size.width, y: dottedLineView.frame.size.height / 2)
                
        path.addLines(between: [startPoint, endPoint])
        shapeLayer.path = path
        dottedLineView.layer.addSublayer(shapeLayer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    @IBAction func acceptBtnTapped(_ sender: UIButton) {
        acceptedButton ()
    }
    
    @IBAction func rejectBtnTapped(_ sender: UIButton) {
    }
}
