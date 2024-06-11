//
//  PaymentMethodVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 13/05/24.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation



class PaymentMethodVC: UIViewController,getAddressWithLatLong, UITextFieldDelegate, UITextViewDelegate,getVichleType,getAdditionalService {
    func serviceList(service: String?) {
        self.additionalServiceTF.text  = service
    }
    
    func vichleTypeList(type: String?) {
        self.vichleTypeTF.text = type
    }
    
    func addressWithLatLong(address: String?, latLong: CLLocationCoordinate2D?) {
        if value == "Pick"{
            self.pickTF.text = address
            print(address ?? "")
        }
        else{
            self.endTF.text = address
        }
    }
    
    
    @IBOutlet weak var vichleTypeTF: UITextField!
    @IBOutlet weak var topBar: ClientTitleBar!
    @IBOutlet weak var pickTF: UITextField!
    @IBOutlet weak var endTF: UITextField!
    @IBOutlet weak var cashView: UIView!
    @IBOutlet weak var walletView: UIView!
    @IBOutlet weak var visaView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var timePicker: UIDatePicker!
      @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var datePickerView: UIView!
    
    @IBOutlet weak var timePickerView: UIView!
    @IBOutlet weak var dateTF: UITextField!
    
    @IBOutlet weak var cashBtn: UIButton!
    @IBOutlet weak var walletBtn: UIButton!
    @IBOutlet weak var visaBtn: UIButton!
    
    @IBOutlet weak var updatePopUpView: UIView!
    @IBOutlet weak var cashRadioImg: UIImageView!
    
    @IBOutlet weak var additionalServiceTF: UITextField!
    @IBOutlet weak var walletRadioImg: UIImageView!
    @IBOutlet weak var visaRadioImg: UIImageView!
     var serviceVehicleId:Int?
    var value:String?
    var date:String?
    var time:String?
    var changeTime:String = ""
    var changeDate:String = ""
    
   override func viewDidLoad() {
        super.viewDidLoad()
       updatePopUpView.isHidden = true
        
        cashView.layer.borderWidth = 0
        cashView.layer.shadowColor = UIColor.lightGray.cgColor
        cashView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cashView.layer.shadowRadius = 2
        cashView.layer.shadowOpacity = 0.3
        cashView.layer.masksToBounds = false
        
        walletView.layer.borderWidth = 0
        walletView.layer.shadowColor = UIColor.lightGray.cgColor
        walletView.layer.shadowOffset = CGSize(width: 0, height: 0)
        walletView.layer.shadowRadius = 2
        walletView.layer.shadowOpacity = 0.3
        walletView.layer.masksToBounds = false
        
        visaView.layer.borderWidth = 0
        visaView.layer.shadowColor = UIColor.lightGray.cgColor
        visaView.layer.shadowOffset = CGSize(width: 0, height: 0)
        visaView.layer.shadowRadius = 2
        visaView.layer.shadowOpacity = 0.3
        visaView.layer.masksToBounds = false
        
        messageView.layer.borderWidth = 0
        messageView.layer.shadowColor = UIColor.lightGray.cgColor
        messageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        messageView.layer.shadowRadius = 2
        messageView.layer.shadowOpacity = 0.3
        messageView.layer.masksToBounds = false
        
        //radio btns
        cashBtn.isSelected = false
        walletBtn.isSelected = false
        visaBtn.isSelected = false
       
       datePickerView.isHidden = true
       timePickerView.isHidden = true
       datePicker.minimumDate = Date()
       datePicker.date = Date()
       timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
       datePicker.addTarget(self, action: #selector(dateeChanged), for: .valueChanged)
       
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
    
    
    
    
    
    
    
    
    
    @IBAction func cashBtnClk(_ sender: UIButton) {
        
        if cashBtn.isSelected == false {
            cashBtn.isSelected = true
            cashRadioImg.image = UIImage(named: "filledRadio")
            walletRadioImg.image = UIImage(named: "radioUnfilled")
            visaRadioImg.image = UIImage(named: "radioUnfilled")
        }
        else {
            cashBtn.isSelected = false
            cashRadioImg.image = UIImage(named: "radioUnfilled")
        }
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
    }
    @IBAction func yesBtnTapped(_ sender: UIButton) {
    }
    
    
    
    
    @IBAction func dateOkBtnTapped(_ sender: UIButton) {
        if self.changeDate == ""{
            CurrentDateAndTimeGet()
        }
        datePickerView.isHidden  = true
    }
    @IBAction func addtionalServiceBtnTapped(_ sender: UIButton) {
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: "AddtionalServiceVC") as! AddtionalServiceVC
                        targetVC.modalPresentationStyle = .overFullScreen
                        targetVC.modalTransitionStyle = .crossDissolve
                        
        targetVC.delegate = self
                        self.present(targetVC, animated: true, completion: nil)
    }
    
    @IBAction func dateCutBtnTapped(_ sender: UIButton) {
        datePickerView.isHidden  = true
    }
    @IBAction func timeOkBtnTapped(_ sender: UIButton) {
        timePickerView.isHidden = true
    }
    
    @IBAction func timeCutBtnTapped(_ sender: UIButton) {
        timePickerView.isHidden = true
    }
    
    
    
    
    
    
    
    @IBAction func walletBtnClk(_ sender: UIButton) {
        if walletBtn.isSelected == false
        {
            walletBtn.isSelected = true
            walletRadioImg.image = UIImage(named: "filledRadio")
            cashRadioImg.image = UIImage(named: "radioUnfilled")
            visaRadioImg.image = UIImage(named: "radioUnfilled")
        }
        else
        {
            walletBtn.isSelected = false
            walletRadioImg.image = UIImage(named: "radioUnfilled")
        }
        
    }
    
    
    
    
    
    
    @IBAction func visaBtnClk(_ sender: UIButton) {
        
        if visaBtn.isSelected == false 
        {
            visaBtn.isSelected = true
            visaRadioImg.image = UIImage(named: "filledRadio")
            cashRadioImg.image = UIImage(named: "radioUnfilled")
            walletRadioImg.image = UIImage(named: "radioUnfilled")
        }
        
        else
        {
            visaBtn.isSelected = false
            visaRadioImg.image = UIImage(named: "radioUnfilled")
        }
    }
    
    @IBAction func vichcleTypeBtnTapped(_ sender: UIButton) {
        
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: "VicheleTypeVC") as! VicheleTypeVC
                        targetVC.modalPresentationStyle = .overFullScreen
                        targetVC.modalTransitionStyle = .crossDissolve
                        
        targetVC.delegate = self
                        self.present(targetVC, animated: true, completion: nil)
                    
        
    }
    
    @IBAction func confirmOrderBtnClk(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ConfirmOrderVC") as! ConfirmOrderVC
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
       // vc.listType = "Language"
       // vc.selectrowdelegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func timeBtnTapped(_ sender: UIButton) {
        timePickerView.isHidden = false
    }
    @IBAction func dateBtnTapped(_ sender: UIButton) {
        datePickerView.isHidden = false
    }
    
    
    
    @IBAction func pickDestinationBtnTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "PinaddressVC") as! PinaddressVC
        self.value = "End"
        vc.delegate = self
     
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func pickPointBtnTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "PinaddressVC") as! PinaddressVC
        self.value = "Pick"
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
