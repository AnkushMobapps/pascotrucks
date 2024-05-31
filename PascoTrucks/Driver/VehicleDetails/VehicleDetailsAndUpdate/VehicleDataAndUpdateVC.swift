//
//  VehicleDataAndUpdateVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 09/05/24.
//

import UIKit
import SDWebImage

class VehicleDataAndUpdateVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
   
    // vies over images
    @IBOutlet weak var vehicleImgView: UIView!
    @IBOutlet weak var drivingLicenseView: UIView!
    @IBOutlet weak var vehicleRcView: UIView!
    
    //images
    @IBOutlet weak var vehicleImage: UIImageView!
    @IBOutlet weak var vehicleLicenseImg: UIImageView!
    @IBOutlet weak var vehicleRcImg: UIImageView!

    //textfields
    @IBOutlet weak var transporterTxt: UITextField!
    @IBOutlet weak var vehicleTxt: UITextField!
    @IBOutlet weak var vehicleNum: UITextField!
    
    var vehicleImg:UIImage?
    var vehicleLicenseImage:UIImage?
    var vehicleRC:UIImage?
    var VehicleObjectID:Int?
    var transportID:Int?
    var selectVehicleId:String?
    var selVehicleId: String?
    
    var selecttypestr:String?
    var selectedProfile:UIImage?
    var uploadDocType:String?

    var getVehicleDataModel:vehicleApprove?
    var updateVehicleDataModel:UpdareVehicleDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vehicleImgView.addDotBorder2(color: #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.3411764706, alpha: 1), thickness: 2.0)
        vehicleImgView.layer.cornerRadius = 20
        
        drivingLicenseView.addDotBorder2(color: #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.3411764706, alpha: 1), thickness: 2.0)
        drivingLicenseView.layer.cornerRadius = 20
        
        vehicleRcView.addDotBorder2(color: #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.3411764706, alpha: 1), thickness: 2.0)
        vehicleRcView.layer.cornerRadius = 20
        
        getVehicleDataApiCall()
    }
    
    @IBAction func transporterListBtn(_ sender: UIButton) {
        
        self.selecttypestr = "Transporter"
        let pc = self.storyboard?.instantiateViewController(withIdentifier: "DropDownListVC") as! DropDownListVC
        pc.modalPresentationStyle = .overFullScreen
        pc.modalTransitionStyle = .crossDissolve
        pc.listType = self.selecttypestr
        pc.selectrowdelegate = self
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
    
    
    @IBAction func selVehicleLicenseBtnClk(_ sender: Any) {
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
                self.vehicleLicenseImg.image = img
                self.vehicleLicenseImage = img
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
    
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editBtnClick(_ sender: UIButton) {
        vehicleDataUpdateApiCall()
      }
    
    
}

extension UIView {
    func addDotBorder2(color: UIColor, thickness: CGFloat) {
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

// MARK: - dropdown list ptotocol
extension VehicleDataAndUpdateVC: selectList {
    func selcetrow(rowid: String, typeID: Int?) {
        if self.selecttypestr == "Transporter" {
            self.transporterTxt.text = rowid
            self.transportID = typeID
        }
        else if self.selecttypestr == "VehicleType"{
            self.vehicleTxt.text = rowid
            self.VehicleObjectID = typeID
        }
        else{
            self.transporterTxt.text = rowid
            self.transportID = typeID
        }
    }
}


// MARK: -  *********    API   **************

extension VehicleDataAndUpdateVC{
    
    func getVehicleDataApiCall(){
        
        let param = [String:Any]()
        print(param)
        VehicleDetailsVM.getVehicleDataApi(viewController: self, parameters:param as NSDictionary){(response) in
            print("success")
            
            self.getVehicleDataModel = response
            
            self.transporterTxt.text = self.getVehicleDataModel?.data?.shipmentname
            self.vehicleTxt.text = self.getVehicleDataModel?.data?.vehiclename
            self.selectVehicleId =  self.getVehicleDataModel?.data?.vehicleid
            print(self.selectVehicleId)
            self.vehicleNum.text = self.getVehicleDataModel?.data?.vehiclenumber
            
            let img1 = self.getVehicleDataModel?.data?.vehicle_photo ?? ""
            let img2 = self.getVehicleDataModel?.data?.driving_license ?? ""
            let img3 = self.getVehicleDataModel?.data?.document ?? ""
            
            if let url = URL(string: image_Url + img1) {
                self.vehicleImage.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
            }
            
            if let url = URL(string: image_Url + img2) {
                self.vehicleLicenseImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
            }
            
            if let url = URL(string: image_Url + img3) {
                self.vehicleRcImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
            }
        }
        
        self.vehicleImg = self.vehicleImage.image
        self.vehicleLicenseImage = self.vehicleLicenseImg.image
        self.vehicleRC = self.vehicleRcImg.image
    }
    
    
    func vehicleDataUpdateApiCall(){
        
        VehicleDetailsVM.UpdateVehicleValidation(viewController: self){
            let param = ["vehiclenumber":self.vehicleNum.text ?? "","cargo":self.selectVehicleId ?? ""] as [String : Any]
            print(param)

            let imgData1 = self.vehicleImg?.jpegData(compressionQuality: 0.4)
            let imgData2 = self.vehicleLicenseImage?.jpegData(compressionQuality: 0.4)
            let imgDat3 = self.vehicleRC?.jpegData(compressionQuality: 0.4)
            VehicleDetailsVM.updateVehicleDataApi(viewController: self, parameter: param as NSDictionary, image1: imgData1!, image2: imgData2!, image3: imgDat3!, imageName1: "vehicle_photo", imageName2: "driving_license", imageName3: "document"){(response) in
                print("success")
                self.updateVehicleDataModel = response
                CommonMethods.showAlertMessage(title: Constant.TITLE, message: response.msg ?? Constant.BLANK, view: self)
            }
        }
    }
}



