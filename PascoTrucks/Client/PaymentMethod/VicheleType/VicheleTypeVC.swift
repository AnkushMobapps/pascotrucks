//
//  VicheleTypeVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 24/05/24.
//

import UIKit
protocol getVichleType: AnyObject {
    func vichleTypeList(type:String?,typeId:Int)
     
}

class VicheleTypeVC: UIViewController {

    @IBOutlet weak var setView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    weak var delegate:getVichleType?
    var vehicleid:Int?
    var value = ["1","2","3","4","5"]
    var vehicleType:VehichleTypeModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "VicheleTypeTVC", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "cell")
        vehicleTypeApi()
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
  

}

extension VicheleTypeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicleType?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VicheleTypeTVC
        cell.nameLbl.text = self.vehicleType?.data?[indexPath.row].vehiclename ?? ""
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VicheleTypeTVC
        let demo = self.vehicleType?.data?[indexPath.row].vehiclename ?? ""
        let id = self.vehicleType?.data?[indexPath.row].id ?? 0
        delegate?.vichleTypeList(type: demo, typeId: id)
        
        self.dismiss(animated: true)
        
    }
    // MARK: vichleTypeApi
    
    func vehicleTypeApi(){
        let param = ["shipment_type":vehicleid ?? 0]
        print(param)
        VehicleTypeViewModel.vehicleTypeApi(viewcontroller: self, parameters: param as NSDictionary){
            response in
            self.vehicleType = response
            print("Success")
            self.myTableView.reloadData()
        }
    }
    
    
}

// MARK: - UIGestureRecognizerDelegate

extension VicheleTypeVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}
