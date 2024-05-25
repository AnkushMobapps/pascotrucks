//
//  ClientOrderVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 13/05/24.
//

import UIKit

class ClientOrderVC: UIViewController {
    @IBOutlet weak var topBar: ClientTitleBar!
    @IBOutlet weak var tbView1: UIView!
    @IBOutlet weak var tbView2: UIView!
    @IBOutlet weak var tbView3: UIView!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var allBidTBView: UITableView!
    @IBOutlet weak var acceptBidTBView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
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
extension ClientOrderVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == orderTableView{
            return 40
        }
        else if tableView == allBidTBView{
            return 40
        }
        else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == orderTableView{
            let cell = orderTableView.dequeueReusableCell(withIdentifier: "ordercell", for: indexPath) as! OrderCell
            cell.selectionStyle = .none
            cell.backgroundColor = .none
            return cell
        }
        else if tableView == allBidTBView {
            let cell = allBidTBView.dequeueReusableCell(withIdentifier: "allBidCell", for: indexPath) as! AllBidCell
            cell.selectionStyle = .none
            cell.backgroundColor = .none
            return cell
        }
        
        else{
            let cell = acceptBidTBView.dequeueReusableCell(withIdentifier: "acceptBidCell", for: indexPath) as! AcceptBidCell
            cell.selectionStyle = .none
            cell.backgroundColor = .none
            return cell
        }
    }
    
    
}
