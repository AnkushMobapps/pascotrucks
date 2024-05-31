//
//  MyWalletVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 25/05/24.
//

import UIKit

class MyWalletVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var withdrawBtn: UIButton!
    @IBOutlet weak var cardView: UIView!
    var walletHistoryCel:String!
    var walletTransactionCell:String!
    
    
    var sagementcontrolStr:String?
   
    
    var lblnameArray = ["History","History","History","History","History","History","History","History"]
    var lblname2Array = ["Transaction","Transaction","Transaction","Transaction","Transaction","Transaction"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sagementcontrolStr = "first"
        
        cardView.layer.borderWidth = 0
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardView.layer.shadowRadius = 2
        cardView.layer.shadowOpacity = 0.3
        cardView.layer.masksToBounds = false
        
        withdrawBtn.layer.borderWidth = 0
        withdrawBtn.layer.shadowColor = UIColor.black.cgColor
        withdrawBtn.layer.shadowOffset = CGSize(width: 0, height: 0)
        withdrawBtn.layer.shadowRadius = 2
        withdrawBtn.layer.shadowOpacity = 0.3
        withdrawBtn.layer.masksToBounds = false
        
        segmentControl.selectedSegmentIndex = 0
        
        let nib1 = UINib(nibName: "MywalletHistoryCell", bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: "walletHistoryCell")
        
        let nib2 = UINib(nibName: "MyTransactionCell", bundle: nil)
         tableView.register(nib2, forCellReuseIdentifier: "transactionCell")
        
        
    }
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func withdrawClk(_ sender: UIButton) {
    }
    
    
    @IBAction func segmentBtnClk(_ sender: UISegmentedControl) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            print("History table is ready to show")
            
            sagementcontrolStr = "first"
            self.tableView.reloadData()
        }
        else{
            print("Transaction table is ready to show")
            
            sagementcontrolStr = "second"
            self.tableView.reloadData()
        }
        
    }
    

}

extension MyWalletVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return showNotificationModel?.data?.count ?? 0
        
        if sagementcontrolStr == "first"
        {
            return lblnameArray.count 
        }
        else
        {
            return lblname2Array.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if sagementcontrolStr == "first"
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "walletHistoryCell") as! MywalletHistoryCell
            cell.selectionStyle = .none
            cell.backgroundColor = .none
            cell.lblName.text = lblnameArray[indexPath.row]
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell") as! MyTransactionCell
            cell.selectionStyle = .none
            cell.backgroundColor = .none
            cell.lblName.text = lblname2Array[indexPath.row]
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   print("mam ji")
    }
}

