//
//  DriverNotesVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 06/06/24.
//

import UIKit

class DriverNotesVC: UIViewController {

    @IBOutlet weak var startDateTxt: UITextField!
    @IBOutlet weak var startTimeTxt: UITextField!
    
    @IBOutlet weak var addTitle: UITextField!
    
    @IBOutlet weak var addDiscription: UITextView!
    var addDriverNoteModel:DriverNoteModel?
   
    override func viewDidLoad() {
        super.viewDidLoad()
     
       
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
  
    @IBAction func startDateBtnClk(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnlyDatePickerVC") as! OnlyDatePickerVC
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.selOnlyDateDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func startTimeBtnClk(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnlyTimePickerVC") as! OnlyTimePickerVC
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.selOnlytimeDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func savebtnClk(_ sender: Any) {
        addDriverNoteapi()
    }
    
}

extension DriverNotesVC:selectedonlyDate,selectedOnlyTime{
    func selOnlytime(time: String?) {
        self.startTimeTxt.text = time
    }
    
    func selOnlyDate(date: String?) {
        self.startDateTxt.text = date
    }
    
  // All api
    func addDriverNoteapi(){
        let reminder = "\(self.startDateTxt.text ?? "") \(self.startTimeTxt.text ?? "")"
        var param = [String:Any]()
        param = [ "title":addTitle.text ?? "","description":addDiscription.text ?? "","reminderdate":reminder]
        print(param)
        DriverNotesViewModel.driverAddNoteApi(viewController: self, parameters: param as NSDictionary){response in
            self.addDriverNoteModel = response
            print("success")
            CommonMethods.showAlertMessageWithHandler(title: Constant.TITLE, message: response?.msg ?? Constant.BLANK, view: self) {
                let vc = self.storyboard?.instantiateViewController(identifier: "GetAndDeleteDriverNoteVC") as! GetAndDeleteDriverNoteVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
  }
    
}

