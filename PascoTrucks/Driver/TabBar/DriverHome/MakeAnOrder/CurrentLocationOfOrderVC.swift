//
//  CurrentLocationOfOrderVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 23/04/24.
//

import UIKit
import SDWebImage

class CurrentLocationOfOrderVC: UIViewController {

    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var cursorView: UIView!
    @IBOutlet weak var topBarView: TitleBar!
    @IBOutlet weak var driverStatusTxt: UILabel!
    
    @IBOutlet weak var clientImg: UIImageView!
    
    @IBOutlet weak var pickUp: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var drop: UILabel!
    var id:Int?
    var driverConfirmBDM:DriverConfirmBidDetailsModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id ?? 0)
        cursorView.layer.borderWidth = 0
        cursorView.layer.shadowColor = UIColor.black.cgColor
        cursorView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cursorView.layer.shadowRadius = 2
        cursorView.layer.shadowOpacity = 0.3
        cursorView.layer.masksToBounds = false
    
        
        backBtnView.layer.borderWidth = 0
        backBtnView.layer.shadowColor = UIColor.black.cgColor
        backBtnView.layer.shadowOffset = CGSize(width: 0, height: 1)
        backBtnView.layer.shadowRadius = 2
        backBtnView.layer.shadowOpacity = 0.3
        backBtnView.layer.masksToBounds = false
    

}
    override func viewWillAppear(_ animated: Bool) {
        driverConfirmBidingDetailMethod()
    }
    
    @IBAction func backBtnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    

    @IBAction func goForPickUpBtnPress(_ sender: UIButton) {
   
        let vc = self.storyboard?.instantiateViewController(identifier: "DiliverdVC") as! DiliverdVC
        
    
        self.navigationController?.pushViewController(vc, animated: true)
    
    
    }
    
    @IBAction func selectDriverStatus(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryCodeVC") as! CountryCodeVC
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.listType = "driverStatus"
        vc.selectListTypeDelegate = self
        self.present(vc, animated: true, completion: nil)
   }
}

extension CurrentLocationOfOrderVC:SelectListType{
    func selectListType(dataName: String, dataId: Int) {
        self.driverStatusTxt.text = dataName
        let statusId = dataId ?? 0
    }
    
    //  min hrs sec conversion
      func convertSecondsToTimeComponents(seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
          let hours = seconds / 3600
          let minutes = (seconds % 3600) / 60
          let remainingSeconds = seconds % 60
          return (hours, minutes, remainingSeconds)
      }
    
    
    func driverConfirmBidingDetailMethod(){
        var param = [String:Any]()
        print(param)
        DriverOrderViewModel.driverConfirmBisDetailsApi(viewController: self, parameters: param as NSDictionary){ response in
            self.driverConfirmBDM = response
             print("success")
            
            let img = self.driverConfirmBDM?.data?.user_image ?? ""
            if let url = URL(string: image_Url + img){
                self.clientImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
            }
            
            self.pickUp.text = self.driverConfirmBDM?.data?.pickup_location ?? ""
            self.drop.text = self.driverConfirmBDM?.data?.drop_location ?? ""
            let duration = self.driverConfirmBDM?.data?.duration ?? 0
            let timeComponents = self.convertSecondsToTimeComponents(seconds: duration)
            print("Hours: \(timeComponents.hours), Minutes: \(timeComponents.minutes), Seconds: \(timeComponents.seconds)")
            let fullduration = "\(timeComponents.minutes) min, \(timeComponents.seconds) sec"
            self.time.text = fullduration
            
             
         }
    }
    
}



