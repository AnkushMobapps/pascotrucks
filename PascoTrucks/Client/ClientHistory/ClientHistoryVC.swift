//
//  ClientHistoryVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 13/05/24.
//

import UIKit

class ClientHistoryVC: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tbView1: UIView!
    @IBOutlet weak var tbView2: UIView!
    @IBOutlet weak var tbView3: UIView!
    @IBOutlet weak var OngoingTableView: UITableView!
    @IBOutlet weak var CompleteTableView: UITableView!
    @IBOutlet weak var CancelledTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.selectedSegmentIndex = 0
        tbView2.isHidden = true
        tbView3.isHidden = true
    }
    
    
    @IBAction func segmentsBtnClk(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tbView1.isHidden = false
            tbView2.isHidden = true
            tbView3.isHidden = true
        }
        else if sender.selectedSegmentIndex == 1{
            tbView1.isHidden = true
            tbView2.isHidden = false
            tbView3.isHidden = true
        }
        else{
            tbView1.isHidden = true
            tbView2.isHidden = true
            tbView3.isHidden = false
        }
        
    }
    
}

extension ClientHistoryVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == OngoingTableView{
            return 5
        }
        else if
            tableView == CompleteTableView{
              return 3
            }
        else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == OngoingTableView{
            let cell = OngoingTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OngoingTVC
        
            return cell
        }
        else if tableView == CompleteTableView{
            let cell = CompleteTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CompletedTVC
        
            return cell
        }
        else{
            let cell = CancelledTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CancelledTVC
        
            return cell
        }
       
        
    }
    
   
}
