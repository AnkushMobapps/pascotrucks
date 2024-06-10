//
//  DatePickerVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 06/06/24.
//

import UIKit

protocol selectedDate: AnyObject {
    func selDate(date:String?, timeTxt:String?)
}

class DatePickerVC: UIViewController {
    
    var selectedDateDelegate:selectedDate?
    
    @IBOutlet weak var selectDate: UIDatePicker!
    
    var changeDate:String?
    var changeTime:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default date to today
        selectDate.date = Date()
        
    }
    
    @IBAction func tabBtnAction(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    

    @IBAction func selectDateBtnClk(_ sender: UIDatePicker) {
        
        let selectedDate = selectDate.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: selectedDate)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"     // "HH:mm"
        let timeString = timeFormatter.string(from: selectedDate)
        
        self.changeDate = dateString
        self.changeTime = timeString
        
        print("Selected Time: \(timeString)")
        print("Selected Date: \(dateString)")
        
        self.selectedDateDelegate?.selDate(date: dateString, timeTxt: timeString )
    
//        let selectedDate = sender.date
//        print("Selected date: \(selectedDate)")
//        
//        // Format and display the date if needed
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        let formattedDate = dateFormatter.string(from: selectedDate)
//        print("Formatted date: \(formattedDate)")
//        
//        self.selectedDateDelegate?.selDate(date: selectedDate, timeTxt: "" )
     
    }
    
    /*
     @objc func dateChanged(_ datePicker: UIDatePicker) {
         let selectedDate = datePicker.date
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         let dateString = dateFormatter.string(from: selectedDate)
         
         let timeFormatter = DateFormatter()
         timeFormatter.dateFormat = "HH:mm"
         let timeString = timeFormatter.string(from: selectedDate)
         
         self.changeDate = dateString
         self.changeTime = timeString
         
 //        print("Selected Time: \(timeString)")
 //        print("Selected Date: \(dateString)")
     }
     */
    

}


// MARK: - UIGestureRecognizerDelegate

extension DatePickerVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}
