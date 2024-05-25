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
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "AddtionalServiceTVC", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
   

}


extension AddtionalServiceVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddtionalServiceTVC
        cell.serviceNameLbl.text = value[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddtionalServiceTVC
        let demo = value[indexPath.row]
        delegate?.serviceList(service:demo)
        
        self.dismiss(animated: true)
        
    }
    
    
}

// MARK: - UIGestureRecognizerDelegate

extension AddtionalServiceVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}
