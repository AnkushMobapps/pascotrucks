//
//  HistoryVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 24/04/24.
//

import UIKit

class HistoryVC: UIViewController {

    @IBOutlet weak var topBarView: TitleBar2!
    @IBOutlet weak var historyTable: UITableView!
    var boxImgArray = [#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare"),#imageLiteral(resourceName: "ticksquare")]
    
    var cellTitileArray = ["Security Updates!",
                           "Multiple Card Features!",
                           "New Updates Available!",
                           "Bank Account Connected!",
                           "Notification Title",
                           "Account Setup Successful!"]
    
    var cellDescriptionArray = [
        "Now Coino has a Two-Factor Authentication. Try it now to make your account more secure.",
        "Now you can also connect Coino with multiple MasterCard & Visa. Try the service now",
        "Update Coino now to get access to the latest features for easier in buy or sell crypto stocks. ",
        "You have linked your account with a local bank. You can withdraw whenever you want.",
        "Your credit card has been successfully linked with Coino. Enjoy our services.",
    ""]
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView.titleName.text = "History"
       
        }
    
    
    func hhhhh() {
        print("hjdkfjksdhfsdajf")
        
        
    }
    
    
}

extension HistoryVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxImgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTable.dequeueReusableCell(withIdentifier: "historyCell") as! HistoryCell
        cell.selectionStyle = .none
        cell.cellImage.image = boxImgArray[indexPath.row]
        cell.celltitle.text = cellTitileArray[indexPath.row]
        cell.day.text = "Today"
        cell.day.text = "9:50 PM"
        cell.cancelButton = {
            self.boxImgArray.remove(at: indexPath.row)
            self.cellTitileArray.remove(at: indexPath.row)
            self.historyTable.reloadData()
        }
       return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let indexPath = historyTable.indexPathForSelectedRow else { return }
//        if indexPath.row == 0 {
//           
//        }
//        else if indexPath.row == 1 {
//            
//        }
//        else if indexPath.row == 2 {
//            
//        }
//        else if indexPath.row == 3 {
//            
//        }
//        
//        else if indexPath.row == 4 {
//           
//        }
//        else if indexPath.row == 5 {
//            
//        }
//       
//        else {
//            
//        }
//    }
}
