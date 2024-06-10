//
//  TitleBar.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 22/04/24.
//

import UIKit



class TitleBar: UIView {

    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var driverImg: UIImageView!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var switchCondition: UISwitch!
    @IBOutlet weak var countOfNotification: UILabel!
    @IBOutlet weak var notificationBtn: UIButton!
    var markOnOffDutyModel:MarkOnAndOffDutyModel?
    var notificationButton:(()->())!
    var onOffSwitchBtn:(()->())!
    var onOffCount:Int?
    override init(frame: CGRect ){
        super.init(frame: frame)
        commitinit()
        onOffCount = 1
    }
    
    @IBAction func notificationBtnClk(_ sender: UIButton) {
        notificationButton()
    }
    
    @IBAction func onOffDutyBtnClk(_ sender: UISwitch) {
        if (sender.isOn == true){
            onOffCount = 1
            markOnOffDutyApi()
               print("on")
           }
           else{
           onOffCount = 0
           markOnOffDutyApi()
               print("off")
           }
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        commitinit()
    }
    
    private func commitinit(){
        Bundle.main.loadNibNamed("TitleBar", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }


}

extension TitleBar{
    func markOnOffDutyApi(){
        let param = ["mark_status":onOffCount]
        DRiverHomeViewModel.onOffDutyApi(view: self, parameter: param as NSDictionary){
            response in
            print("success")
            self.markOnOffDutyModel = response
            let onOffCheck = self.markOnOffDutyModel?.Duty
            UserDefaults.standard.setValue(onOffCheck, forKey: "Duty")
        }
        
    }
}
