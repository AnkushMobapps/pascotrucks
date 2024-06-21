//
//  GetAndDeleteDriverNoteVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 11/06/24.
//

import UIKit

class GetAndDeleteDriverNoteVC: UIViewController {
    
    @IBOutlet weak var noteAndReminderTable: UITableView!
    @IBOutlet weak var emptyNotes: UIView!
 
    var boxImgArray = [#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare")]
    var getDriverNotesModel:DriverGetNotesModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getDriverNotesApi()
    }
    
    @IBAction func addNotesBtnClk(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DriverNotesVC") as! DriverNotesVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension GetAndDeleteDriverNoteVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getDriverNotesModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = noteAndReminderTable.dequeueReusableCell(withIdentifier: "addNotesCell") as! DriverNoteCell
        cell.noteimage.image = #imageLiteral(resourceName: "ticksquare")
        
        //        cell.notiFiId = self.getDriverNotesModel?.data?[indexPath.row].id ?? 0
        print(cell.notiFiId ?? 0)
        
        cell.title.text = self.getDriverNotesModel?.data?[indexPath.row].title ?? ""
        
        cell.noteDescription.text = self.getDriverNotesModel?.data?[indexPath.row].description ?? ""
        
        cell.dateTime.text = self.getDriverNotesModel?.data?[indexPath.row].reminderdate ?? ""
        
        cell.deleteButton = {
            let notificationId = self.getDriverNotesModel?.data?[indexPath.row].id ?? 0
            print(notificationId)
            self.deleteNotes(deleteId: notificationId)
        }
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //    }
    
    // api
    func getDriverNotesApi(){
        var param = [String:Any]()
        DriverNotesViewModel.driverGetNotesApi(viewController: self, parameters: param as NSDictionary){
            response in
            print(UserDefaults.standard.string(forKey: "token") ?? "")
            self.getDriverNotesModel = response
            print("success")
            let count = self.getDriverNotesModel?.data?.count ?? 0
            if count == 0{
                self.emptyNotes.isHidden = false
            }
            else{
                self.emptyNotes.isHidden = true
            }
            self.noteAndReminderTable.reloadData()
            
        }
        
    }
    
    
    func deleteNotes(deleteId:Int?){
        var param = ["Id":deleteId ?? 0]
        DriverNotesViewModel.driverDeleteNotesApi(viewController: self, parameters: param as NSDictionary){responseObject in
            print("Success")
            
            self.getDriverNotesApi()
        }
    }
    
}
