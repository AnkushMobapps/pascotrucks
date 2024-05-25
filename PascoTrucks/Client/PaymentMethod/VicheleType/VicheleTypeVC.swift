//
//  VicheleTypeVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 24/05/24.
//

import UIKit
protocol getVichleType: AnyObject {
    func vichleTypeList(type:String?)
     
}

class VicheleTypeVC: UIViewController {

    @IBOutlet weak var setView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    weak var delegate:getVichleType?
    var value = ["1","2","3","4","5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "VicheleTypeTVC", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "cell")
       
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
  

}

extension VicheleTypeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VicheleTypeTVC
        cell.nameLbl.text = value[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VicheleTypeTVC
        let demo = value[indexPath.row]
        delegate?.vichleTypeList(type: demo)
        
        self.dismiss(animated: true)
        
    }
    
    
}

// MARK: - UIGestureRecognizerDelegate

extension VicheleTypeVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}
