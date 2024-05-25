//
//  VehicleDetailsVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 17/04/24.
//

import UIKit
class VehicleDetailsVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var vehicleImgView: UIView!
    @IBOutlet weak var drivingDocView: UIView!
    @IBOutlet weak var vehicleRcView: UIView!
    
    //images
    
    @IBOutlet weak var vehicleImage: UIImageView!
    @IBOutlet weak var vehicleDocImg: UIImageView!
    @IBOutlet weak var vehicleRcImg: UIImageView!
    
    //vehicle lists Btns
    @IBOutlet weak var vehicleImgBtn: UIButton!
    @IBOutlet weak var vehicleDocBtn: UIButton!
    @IBOutlet weak var vehicleRCBtn: UIButton!
    
    //textfields
    @IBOutlet weak var transporterTxt: UITextField!
    @IBOutlet weak var vehicleTxt: UITextField!
    @IBOutlet weak var countryTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var vehicleNoTxt: UITextField!
    
    var selectedProfile:UIImage?
    var transportID:Int?
    var vehicleID:Int?
    var selVehicleId: String?
    var countryId:Int?
    var cityId:Int?
    var selecttypestr:String?
    var txtString:String!
    var uploadDocType:String?
    
    var vehicleImg:UIImage?
    var vehicleDoc:UIImage?
    var vehicleRC:UIImage?
    var approvalModel:ApprovalModel?
    
    var cityName:String?
    var countryName:String?
    var userID:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        vehicleImgView.addDotBorder(color: #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.3411764706, alpha: 1), thickness: 2.0)
        vehicleImgView.layer.cornerRadius = 20
        
        drivingDocView.addDotBorder(color: #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.3411764706, alpha: 1), thickness: 2.0)
        drivingDocView.layer.cornerRadius = 20
        
        vehicleRcView.addDotBorder(color: #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.3411764706, alpha: 1), thickness: 2.0)
        vehicleRcView.layer.cornerRadius = 20
        
        cityTxt.text = cityName
        countryTxt.text = countryName
    }
    
    
    // MARK: -  Navigation
    
    @IBAction func transporterListBtn(_ sender: UIButton) {
        
        self.selecttypestr = "Transporter"
        let pc = self.storyboard?.instantiateViewController(withIdentifier: "DropDownListVC") as! DropDownListVC
        pc.modalPresentationStyle = .overFullScreen
        pc.modalTransitionStyle = .crossDissolve
        pc.listType = self.selecttypestr
        pc.selectrowdelegate = self
        // transporterTxt.text = selcetrow(rowid: String)
        self.present(pc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func vehicleTypeBtn(_ sender: UIButton) {
        self.selecttypestr = "VehicleType"
        let pc = self.storyboard?.instantiateViewController(withIdentifier: "DropDownListVC") as! DropDownListVC
        pc.modalPresentationStyle = .overFullScreen
        pc.modalTransitionStyle = .crossDissolve
        pc.listType = self.selecttypestr
        pc.typeSelected_ID = transportID
        pc.selectrowdelegate = self
        self.present(pc, animated: true, completion: nil)
    }

    @IBAction func selVehicleImgclk(_ sender: Any) {
        self.uploadDocType = "VehicleImage"
        imgPopUp()
    }
    
    
    @IBAction func selVehicleDocBtnClk(_ sender: Any) {
        self.uploadDocType = "VehicleDoc"
        imgPopUp()
    }
    
    
    @IBAction func selVehicleRCBtnClk(_ sender: Any) {
        self.uploadDocType = "VehicleRC"
        imgPopUp()
    }
    //MARK: - Select  Photo from Gallery
    
    func showImagePicker(selectedSource: UIImagePickerController.SourceType){
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else {
            print("Selected source not Available")
            return
        }
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = selectedSource
        picker.allowsEditing = false
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage]as? UIImage{
            
            if  self.uploadDocType == "VehicleImage"{
                self.vehicleImage.image = img
                self.vehicleImg = img
            }
            else if self.uploadDocType == "VehicleDoc"{
                self.vehicleDocImg.image = img
                self.vehicleDoc = img
            }
            else if self.uploadDocType == "VehicleRC"{
                self.vehicleRcImg.image = img
                self.vehicleRC = img
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    func imgPopUp(){
        let alert = UIAlertController(title: "Select Image", message: "Select image from ?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            print("Camera")
            self.showImagePicker(selectedSource: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (UIAlertAction) in
            print("Photo Gallery")
            self.showImagePicker(selectedSource: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func vehicleBtnClk(_ sender: UIButton) {
        
    }
    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        newApproval()
       
    }
}

extension UIView {
    func addDotBorder(color: UIColor, thickness: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color.cgColor
        borderLayer.lineDashPattern = [2, 2] // Adjust the pattern as needed
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(rect: bounds).cgPath
        borderLayer.lineWidth = thickness
        layer.addSublayer(borderLayer)
    }
}

// MARK: - selectList *********

extension VehicleDetailsVC: selectList {
    func selcetrow(rowid: String, typeID: Int?) {
        if self.selecttypestr == "Transporter" {
            self.transporterTxt.text = rowid
            self.transportID = typeID
        }
        else if self.selecttypestr == "VehicleType"{
            self.vehicleTxt.text = rowid
            self.vehicleID = typeID
        }
        else{
            self.transporterTxt.text = rowid
            self.transportID = typeID
        }

        
    }
}

// MARK: -  ***********    API    ***************

extension VehicleDetailsVC {
    
  func newApproval(){
      let param = [ "cargo": vehicleID ?? 0 ,"vehiclenumber":vehicleNoTxt.text ?? ""] as [String : Any]
        print(param)
      
        let imgData1 = self.vehicleImg?.jpegData(compressionQuality: 0.4)
        let imgData2 = self.vehicleDoc?.jpegData(compressionQuality: 0.4)
        let imgData3 = self.vehicleRC?.jpegData(compressionQuality: 0.4)
      
        VehicleDetailsVM.ApprovalApi(viewController: self, parameters: param as NSDictionary, Image: imgData1!, frontImage: imgData2!, backImage: imgData3!, ImgName: "vehicle_photo", frontImageName: "document", backImageName: "driving_license"){
            (response) in
             print("success")
             self.approvalModel = response
             print(response)
            
            CommonMethods.showAlertMessageWithHandler(title: Constant.TITLE, message: response.msg ?? Constant.BLANK, view: self) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
     }
}


