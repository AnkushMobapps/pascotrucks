//
//  ClientProfileVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 30/05/24.
//

import UIKit
import SDWebImage
// New Pull

class ClientProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailidTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    var selectedProfile:UIImage?
   
    var updateProfilrModel:ClientProfileModel?
    var getProfile:GetProfileModel?
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.cityTF.text = UserDefaults.standard.string(forKey: "cityName")
        print(self.cityTF.text)
        selectedProfile = userImg.image
    }
    override func viewWillAppear(_ animated: Bool) {
        getProfileApi()
    }
    

    @IBAction func cameraBtnTapped(_ sender: UIButton) {
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
    
    @IBAction func updateBtnTapped(_ sender: UIButton) {
        clientUpdateProfileApi()
    }
    
    
    // MARK: Client Update Profile Api
    
    func clientUpdateProfileApi(){
        ClientProfileViewModel.Validation(viewController: self){
            let param = ["full_name":self.userNameTF.text ?? "", "email":self.emailidTF.text ?? "", "current_city":self.cityTF.text ?? ""]
            
            print(param)
            
            self.selectedProfile = self.userImg.image
            let imgData = self.selectedProfile?.jpegData(compressionQuality: 0.4)
            ClientProfileViewModel.clientUpdateProfileApi(viewController: self, parameter: param as NSDictionary, image: imgData!, imageName: "image")
            {     (responseObject) in
                self.updateProfilrModel = responseObject
                print("success")
                
                
                let profileStatus = self.updateProfilrModel?.profile ?? 0
                UserDefaults.standard.setValue(profileStatus, forKey: "profile")
                print(profileStatus)
                
                self.getProfileApi()
                CommonMethods.showAlertMessageWithHandler(title: Constant.BLANK, message: self.updateProfilrModel?.msg ?? "", view: self){
                    let vc = self.storyboard?.instantiateViewController(identifier: "ClientTabBarViewController") as! ClientTabBarViewController
                    self.navigationController?.pushViewController(vc, animated: true)
//                    // Navigation - AddHostVC
//                    let controllers = self.navigationController?.viewControllers
//                    for vc in controllers! {
////                        if vc is MyPlacesVC {
////                            _ = self.navigationController?.popToViewController(vc as! MyPlacesVC, animated: true)
////                        }
//                    }
                    

                }
                
            }
            
        }
        
    }
    
    
    // MARK: - Get Profile Api (){
    func getProfileApi(){
        let param = [String:Any] ()
        ClientProfileViewModel.getProfileApi(viewController: self, parameters: param as NSDictionary) { response in
            self.getProfile = response
            print("Suceess")
            
            self.userNameTF.text = self.getProfile?.data?.full_name
            self.emailidTF.text = self.getProfile?.data?.email
//            self.phoneNoTxt.text = self.getProfile?.data?.phone_number
//            self.cityTF.text = self.getProfile?.data?.current_city
          
            let img = self.getProfile?.data?.image ?? ""
            if img != ""{
                    if let url = URL(string: image_Url + img) {
                        self.userImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
            }
                else{
                    self.userImg.image = #imageLiteral(resourceName: "user1")
                    
                }
            
                
            }
            
        }
        
    }
    
    
}
