//
//  WelcomeVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 16/04/24.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var viewOverSelectField: UIView!
    @IBOutlet weak var selectField: UITextField!
    @IBOutlet weak var viewForLanguage: UIView!
    @IBOutlet weak var languagetable: UITableView!
    var languageArray = ["Hindi","English","Arabic","Russian"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
   // startedView.GradientColor(colorOne: #colorLiteral(red: 0.8352941176, green: 0.6549019608, blue: 0.3764705882, alpha: 1), colorTwo: #colorLiteral(red: 0.6117647059, green: 0.4705882353, blue: 0.231372549, alpha: 1))

    }
    
    @IBAction func languageListBtn(_ sender: UIButton) {
     let pc = self.storyboard?.instantiateViewController(withIdentifier: "DropDownListVC") as! DropDownListVC
        pc.modalPresentationStyle = .overFullScreen
        pc.modalTransitionStyle = .crossDissolve
        pc.listType = "Language"
        pc.selectrowdelegate = self
        self.present(pc, animated: true, completion: nil)
     }
    
    @IBAction func nextBtnClick(_ sender: UIButton) {
        if selectField.text?.isEmpty == false {
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "Select Any Language", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
extension WelcomeVC:selectList{
    func selcetrow(rowid: String, typeID: Int?) {
        selectField.text = rowid
    }
    
 
}

