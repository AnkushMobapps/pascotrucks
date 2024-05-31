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
   
    @IBOutlet weak var datePickerView: UIView!
   @IBOutlet weak var timePickerView: UIView!
  @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeTF: UITextField!
    
    var date:String?
    var time:String?
    var changeTime:String = ""
    var changeDate:String = ""
    
    
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
        datePickerView.isHidden = true
        timePickerView.isHidden = true
        
        datePicker.minimumDate = Date()
        datePicker.date = Date()
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        datePicker.addTarget(self, action: #selector(dateeChanged), for: .valueChanged)
    }
    
    // MARK: - Time Picker
       
        @objc func timeChanged(_ datePicker: UIDatePicker) {
            let selectedDate = timePicker.date
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            let timeString = timeFormatter.string(from: selectedDate)
            self.changeTime = timeString
            print("Selected Time: \(timeString)")
            self.timeTF.text = self.changeTime
            
        }
       
       
       
       
       //MARK: - Get current date and time
       
       func CurrentDateAndTimeGet(){
           
           let currentDateAndTime = Date()
           
           // Extract date components
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           let currentDate = dateFormatter.string(from: currentDateAndTime)
           print("Current Date: \(currentDate)")
           self.changeDate = currentDate
           self.dateTF.text = self.changeDate
       }
   
        
       
       // MARK: - Date Picker
       
        @objc func dateeChanged(_ datePicker: UIDatePicker) {
            let selectedDate = datePicker.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: selectedDate)
            self.changeDate = dateString
            self.dateTF.text =   self.changeDate
            print(changeDate)
            print("Selected Date: \(dateString)")
        }
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func proceedBtnTapped(_ sender: UIButton) {
    }
    
    @IBAction func startDateBtnTapped(_ sender: UIButton) {
        self.datePickerView.isHidden = false
    }
    @IBAction func timeBtnTapped(_ sender: UIButton) {
        self.timePickerView.isHidden = false
    }
    
    
    
    
    
    
    @IBAction func gestureBtnClk(_ sender: Any)
    {
        self.dismiss(animated: true)
    }
    
//    @IBAction func tapGuestureBtnClick(_ sender: UITapGestureRecognizer) {
//        self.dismiss(animated: true)
//    }
    @IBAction func timeOkBtnTapped(_ sender: UIButton) {
        timePickerView.isHidden = true
    }
    @IBAction func timeCutBtnTapped(_ sender: UIButton) {
        timePickerView.isHidden = true
    }
    @IBAction func dateCutBtnTapped(_ sender: UIButton) {
        datePickerView.isHidden  = true
    }
    @IBAction func dateOkBtnTapped(_ sender: UIButton) {
        if self.changeDate == ""{
            CurrentDateAndTimeGet()
        }
        datePickerView.isHidden  = true
    }
    
    
    
    
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

