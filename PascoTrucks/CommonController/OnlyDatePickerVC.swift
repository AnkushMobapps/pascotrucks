//
//  OnlyDatePickerVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 10/06/24.
//

import UIKit
protocol selectedonlyDate: AnyObject {
    func selOnlyDate(date:String?)
}

class OnlyDatePickerVC: UIViewController {
    
    var selOnlyDateDelegate:selectedonlyDate?
    @IBOutlet weak var datePicker: UIDatePicker!
    var changeDate:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set default date to today
        datePicker.date = Date()
        
    }
    

    @IBAction func datePickerBtnClk(_ sender: UIDatePicker) {
        let selectedDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: selectedDate)
        self.changeDate = dateString
        print("Selected Date: \(dateString)")
        self.selOnlyDateDelegate?.selOnlyDate(date: dateString)
        
    }
    
    
    @IBAction func tapActionBtnClk(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    

}

// MARK: - UIGestureRecognizerDelegate

extension OnlyDatePickerVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}
