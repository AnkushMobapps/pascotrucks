//
//  NotificationVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 19/04/24.
//

import UIKit

class NotificationVC: UIViewController {
    
    @IBOutlet weak var notificationTable: UITableView!
    @IBOutlet weak var clearAllNotificationBtn: UIButton!
    @IBOutlet weak var noNotificationImg: UIImageView!
    
    
    var showNotificationModel:ShowNotificationModel?
    var deletePertiNotiModel:DeletePerticularNotifiModel?
    var boxImgArray = [#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare")]
    var NotificationId:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        showNotificationApiCall()
    }
    
    @IBAction func clearAllNotiBtnClk(_ sender: UIButton) {
        clearAllNotifiApiCall()
    }
}



// MARK: - UITableViewDelegate, UITableViewDataSource

extension NotificationVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showNotificationModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTable.dequeueReusableCell(withIdentifier: "notificationCelll") as! NotificationCell
        cell.notificationTitle.text = self.showNotificationModel?.data?[indexPath.row].notification_title ?? ""
        cell.notiDescription.text = self.showNotificationModel?.data?[indexPath.row].notification_description ?? ""
        cell.dateTime.text = self.showNotificationModel?.data?[indexPath.row].created_at ?? ""
        cell.notiFiId = self.showNotificationModel?.data?[indexPath.row].id ?? 0
        cell.deleteButton = {
            self.NotificationId = cell.notiFiId
            print(self.NotificationId!)
            self.deletPertiNotifiApiCall()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ConfirmOrderVC") as! ConfirmOrderVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // show Notification list
    
    func showNotificationApiCall(){
        let param = [String:Any]()
        NotificationViewModel.showNotificationApi(viewController: self, parameters: param as NSDictionary){(response) in
            print("success")
            self.showNotificationModel = response
            var count =  self.showNotificationModel?.data?.count ?? 0
            print(count)
            
            if count == 0{
                self.clearAllNotificationBtn.isHidden = true
                self.noNotificationImg.isHidden = false
            }
            else{
                self.clearAllNotificationBtn.isHidden = false
                self.noNotificationImg.isHidden = true
            }
            
            //            self.clearAllNotificationBtn.isHidden = count == 0 ? true : false
            
            self.notificationTable.reloadData()
        }
    }
    
    // delet Perti NotifiApiCall list
    
    func deletPertiNotifiApiCall(){
        let Param = ["id":NotificationId]
        NotificationViewModel.deletePerticularNotifiApi(viewController: self, parameters: Param as NSDictionary){(response) in
            self.deletePertiNotiModel = response
            print(response!)
            self.showNotificationApiCall()
        }
    }
    
    //clear All notification api
    
    func clearAllNotifiApiCall(){
        let param = [String:Any]()
        NotificationViewModel.clearAllNotifiApi(viewController: self, parameter: param as NSDictionary){
            (response) in
            print(response!)
            self.showNotificationApiCall()
        }
    }
    
}
