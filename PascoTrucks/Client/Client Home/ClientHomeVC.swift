//
//  ClientHomeVC.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 13/05/24.
//

import UIKit
import SDWebImage

class ClientHomeVC: UIViewController {
    @IBOutlet weak var clientTopBar: ClientTitleBar!
    @IBOutlet weak var myColView: UICollectionView!
    @IBOutlet weak var gridCollectionView: UICollectionView!
    @IBOutlet weak var myPageing: UIPageControl!
    var value:String?
    @IBOutlet weak var coupanView: UIView!
    @IBOutlet weak var bonusView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var emergencyView: UIView!
    var topImgArray = [#imageLiteral(resourceName: "pnggg"),#imageLiteral(resourceName: "maskgroup"),#imageLiteral(resourceName: "maskgroup"),]
    var gridImg = [#imageLiteral(resourceName: "heavyTransport"),#imageLiteral(resourceName: "heavyTransport"),#imageLiteral(resourceName: "heavyTransport"),#imageLiteral(resourceName: "heavyTransport"),#imageLiteral(resourceName: "heavyTransport"),#imageLiteral(resourceName: "heavyTransport"),#imageLiteral(resourceName: "heavyTransport"),#imageLiteral(resourceName: "heavyTransport"),#imageLiteral(resourceName: "heavyTransport"),#imageLiteral(resourceName: "heavyTransport"),#imageLiteral(resourceName: "heavyTransport")]
    var clientServiceModel:ClientServiceModel?
    var userType:String?
    var homePageing:HomePageingModel?
    
    var timer:Timer?
    var currentcellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for coupan
        coupanView.layer.cornerRadius = 5
        coupanView.layer.borderWidth = 0
        coupanView.layer.shadowColor = UIColor.black.cgColor
        coupanView.layer.shadowOffset = CGSize(width: 0, height: 2)
        coupanView.layer.shadowRadius = 2
        coupanView.layer.shadowOpacity = 0.3
        coupanView.layer.masksToBounds = false
        //for bonus
        bonusView.layer.cornerRadius = 5
        bonusView.layer.borderWidth = 0
        bonusView.layer.shadowColor = UIColor.black.cgColor
        bonusView.layer.shadowOffset = CGSize(width: 0, height: 2)
        bonusView.layer.shadowRadius = 2
        bonusView.layer.shadowOpacity = 0.3
        bonusView.layer.masksToBounds = false
        //for help
        helpView.layer.cornerRadius = 5
        helpView.layer.borderWidth = 0
        helpView.layer.shadowColor = UIColor.black.cgColor
        helpView.layer.shadowOffset = CGSize(width: 0, height: 2)
        helpView.layer.shadowRadius = 2
        helpView.layer.shadowOpacity = 0.3
        helpView.layer.masksToBounds = false
        //for emergency
        emergencyView.layer.cornerRadius = 5
        emergencyView.layer.borderWidth = 0
        emergencyView.layer.shadowColor = UIColor.black.cgColor
        emergencyView.layer.shadowOffset = CGSize(width: 0, height: 2)
        emergencyView.layer.shadowRadius = 2
        emergencyView.layer.shadowOpacity = 0.3
        emergencyView.layer.masksToBounds = false
        self.userType = "user"
        
        getClentserviceApi()
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        myPageing.numberOfPages = 3
        
        myPageing.currentPage = 0
        myPageing.numberOfPages = topImgArray.count
        
        homePageingApi()
    }
    
    
    @objc func slideToNext()
    {
        if currentcellIndex+1 == topImgArray.count
        {
            currentcellIndex = 0
            //mycollectionviewib.isPagingEnabled = false
            myColView.scrollToItem(at: IndexPath(item: currentcellIndex, section: 0),at: .right, animated: true)
            myColView.isPagingEnabled = true
            
        }
        else{
            currentcellIndex = currentcellIndex + 1
            myColView.isPagingEnabled = false
            myColView.scrollToItem(at: IndexPath(item: currentcellIndex, section: 0),at: .right, animated: true)
            myColView.isPagingEnabled = true
            
        }
        myPageing.currentPage = currentcellIndex
    }
   
}

// MARK: - UICollectionViewDelegate,UICollectionViewDataSource

extension ClientHomeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  collectionView == myColView {
            return homePageing?.data?.count ?? 0
        }
        else{
            return clientServiceModel?.data?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == myColView {
            let cell = myColView.dequeueReusableCell(withReuseIdentifier: "topIngCell", for: indexPath) as! TopImgCell
           
            cell.backgroundColor = .none
//            cell.topImg.image = topImgArray[indexPath.row]
            
            let img = self.homePageing?.data?[indexPath.row].slideimage ?? ""
            if let url = URL(string: image_Url + img){
                cell.topImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
            }
            return cell
        }
        else {
            let cell = gridCollectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! GridCollectionCell
            let img = self.clientServiceModel?.data?[indexPath.row].shipmentimage ?? ""
            if let url = URL(string: image_Url + img){
                cell.cellImg.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0))
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == gridCollectionView{
            let vc = self.storyboard?.instantiateViewController(identifier: "PaymentMethodVC") as! PaymentMethodVC
            let id = self.clientServiceModel?.data?[indexPath.row].shipmentid
            vc.serviceVehicleId = self.clientServiceModel?.data?[indexPath.row].shipmentid
           
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        if collectionView == myColView {
//            let widht = myColView.bounds.width
//            return CGSize(width: widht, height: 174)
//        }
//        
//        else {
//            let padding: CGFloat = 20
//            let collectionViewSize = gridCollectionView.frame.size.width - padding
//            return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        if collectionView == gridCollectionView{
//            return 20
//        }
//        return 10
//    }
    
    
    
    
    // MARK: Home Pageing Api
    func homePageingApi(){
        let param = ["user_type":userType]
        ClientHomeViewModel.homePageingApi(viewcontroller: self, parameters: param as NSDictionary){
            response in
            self.homePageing = response
            print("success")
            self.myColView.reloadData()
            
        }
    }
    
}


extension ClientHomeVC {
    func getClentserviceApi(){
        let param = [String:Any]()
        ClientHomeViewModel.clientServicelistApi(viewController: self, parameters: param as NSDictionary){
            (response) in
            print("success")
            self.clientServiceModel = response
            self.gridCollectionView.reloadData()
            print(response!)
        }
    }
}
