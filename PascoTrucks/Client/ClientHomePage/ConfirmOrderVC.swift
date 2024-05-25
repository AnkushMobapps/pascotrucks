//
//  ConfirmOrderVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 15/05/24.
//

import UIKit

class ConfirmOrderVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dotLine1: UIView!
    @IBOutlet weak var dotLine2: UIView!
    @IBOutlet weak var dotLine3: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dotLine1.drawDottedLine(start: CGPoint(x: dotLine1.bounds.minX, y: dotLine1.bounds.minY), end: CGPoint(x: dotLine1.bounds.maxX, y: dotLine1.bounds.minY), view: dotLine1)
        
        dotLine2.drawDottedLine(start: CGPoint(x: dotLine2.bounds.minX, y: dotLine2.bounds.minY), end: CGPoint(x: dotLine2.bounds.maxX, y: dotLine2.bounds.minY), view: dotLine2)
        
        dotLine3.drawDottedLine(start: CGPoint(x: dotLine3.bounds.minX, y: dotLine3.bounds.minY), end: CGPoint(x: dotLine3.bounds.maxX, y: dotLine3.bounds.minY), view: dotLine3)
     
        mainView.layer.borderWidth = 0
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowRadius = 2
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.masksToBounds = false
        
      
    }
    
    
    @IBAction func gestureBtnClk(_ sender: Any)
    {
        self.dismiss(animated: true)
    }
    
//    @IBAction func tapGuestureBtnClick(_ sender: UITapGestureRecognizer) {
//        self.dismiss(animated: true)
//    }
}
//dotted line
extension UIView{
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
}



// MARK: - UIGestureRecognizerDelegate

extension ConfirmOrderVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}

