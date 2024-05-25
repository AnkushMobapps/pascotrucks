//
//  ProfileVC.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 19/04/24.
//

import UIKit
import SDWebImage

class ProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
 //user form
   @IBOutlet weak var viewOverImage: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneNoTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
 
    var updateProfilrModel:UpdareProfileModel?
    var profileDataModel: ProfileDataModel?
    var userid:String?
    var userType:String?
    var selectedProfile:UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewOverImage.layer.borderWidth = 2
        viewOverImage.layer.borderColor = UIColor.white.cgColor
        getProfileDataApi()
        
    }
    
    @IBAction func chooseprofileBtnClick(_ sender: Any) {
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage]as? UIImage{
            self.userImg.image = img
            self.selectedProfile = img
        }
        self.dismiss(animated: true, completion: nil)
    }
    
 
    
    @IBAction func updateBtnClk(_ sender: UIButton) {
        updateProfileDataApi()
    }

    @IBAction func vehicleBtnClk(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VehicleDataAndUpdateVC") as! VehicleDataAndUpdateVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

// MARK: - ************    API   ***************

extension ProfileVC {
    
    // Get profile Details ========
    
    func getProfileDataApi(){
        let param = [String:Any]()
        ProfileViewModel.getProfileDetails(viewController: self, parameters: param as NSDictionary){responseObject in
            print("Success")
            self.profileDataModel = responseObject
            print(responseObject)
            self.nameTxt.text = self.profileDataModel?.data?.full_name
             self.emailTxt.text = self.profileDataModel?.data?.email
            self.phoneNoTxt.text = self.profileDataModel?.data?.phone_number
            self.cityTxt.text = self.profileDataModel?.data?.current_city
            let img = self.profileDataModel?.data?.image ?? ""
            if let url = URL(string: image_Url + img) {
                self.userImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
     
            }
        }
    }
    
// Update profile ========
   func updateProfileDataApi(){
        let param = ["full_name":nameTxt.text ?? "","email":emailTxt.text ?? "","phone_number":phoneNoTxt.text ?? "","current_city":cityTxt.text ?? ""]
        print(param)
        self.selectedProfile = self.userImg.image
        let imgData = self.selectedProfile?.jpegData(compressionQuality: 0.4)
        UpdateProfileViewModel.updateProfileData(viewController: self, parameter: param as NSDictionary, image:imgData!,imageName: "image") {(responseObject) in
            print("success")
            self.updateProfilrModel = responseObject
  
        }
    }
}

