//
//  AddtionalServiceVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 24/05/24.
//

import UIKit

protocol getAdditionalService: AnyObject {
    func serviceList(service:String?)
     
}


class AddtionalServiceVC: UIViewController {

    @IBOutlet weak var setView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    
    var value = ["Coustem"]
    weak var delegate:getAdditionalService?
    var addtionalService:AddtioalServiceModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "AddtionalServiceTVC", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "cell")
        
        addtionalServiceApi()
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
   

}


extension AddtionalServiceVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addtionalService?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddtionalServiceTVC
        cell.serviceNameLbl.text = addtionalService?.data?[indexPath.row].additional_type ?? ""
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddtionalServiceTVC
        let demo = addtionalService?.data?[indexPath.row].additional_type ?? ""
        delegate?.serviceList(service:demo)
        
        self.dismiss(animated: true)
        
    }
    // MARK: - AdditionalServiceApi
    func addtionalServiceApi(){
        let param = [String:Any]()
        AddtionalServiceViewModel.addtionalServiceApi(viewController: self, parameters: param as NSDictionary) {
            response in
            self.addtionalService = response
            print("succeess")
            self.myTableView.reloadData()
        }
    }
 

    
    
    
}

// MARK: - UIGestureRecognizerDelegate

extension AddtionalServiceVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}
