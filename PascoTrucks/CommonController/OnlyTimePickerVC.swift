//
//  OnlyTimePickerVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 10/06/24.
//

import UIKit
protocol selectedOnlyTime: AnyObject {
    func selOnlytime(time:String?)
}

class OnlyTimePickerVC: UIViewController {
    var selOnlytimeDelegate:selectedOnlyTime?
    
    var changeTime:String?
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default date to today
        timePicker.date = Date()
       
    }
    
    @IBAction func tapGuestureBtnClick(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    @IBAction func timePickerBtnClk(_ sender: UIDatePicker) {
        let selectedTime = timePicker.date
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mma"     // "HH:mm:ss"
        let timeString = timeFormatter.string(from: selectedTime)
        self.changeTime = timeString
        print("Selected Time: \(timeString)")
        self.selOnlytimeDelegate?.selOnlytime(time: timeString)
     }
    
}
