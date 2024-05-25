//
//  CountryCodeVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 01/05/24.
//

import UIKit

protocol SelectCountryCode:NSObject{
     func selectCCnCode(countryId:String)
}

class CountryCodeVC: UIViewController {
    
var CountryCodeDelegate:SelectCountryCode?
    
@IBOutlet weak var viewOverTable: UIView!
@IBOutlet weak var countryCodeTableView: UITableView!
    
    var countryCodeArray = ["+91","+92","+91","+93","+94","+95","+266","+235"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 }

}

// MARK: - UITableViewDelegate,UITableViewDataSource

extension CountryCodeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryCodeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryCodeTableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryCodeCell
        cell.selectionStyle = .none
        cell.backgroundColor = .none
        cell.countryCodeTxt.text = countryCodeArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectString = countryCodeArray[indexPath.row]
       // print(selectString)
        self.CountryCodeDelegate?.selectCCnCode(countryId: selectString)
        self.dismiss(animated: true)
    }
}
