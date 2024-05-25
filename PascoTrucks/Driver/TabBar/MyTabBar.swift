//
//  MyTabBar.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 19/04/24.
//

import UIKit

class MyTabBar: UITabBarController {
    var driverCountNotiModel:CountNotificationModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard let viewControllers = self.viewControllers, viewControllers.count > 3 else {
//            return
//        }
//        
//        let thirdTabBarItem = viewControllers[3].tabBarItem
//        thirdTabBarItem?.badgeValue = "50"
//        if #available(iOS 10.0, *) {
//            thirdTabBarItem?.badgeColor = UIColor.red
//        }
        driverCountNotiApiMethod()
        
        
        // Customize the appearance of the tab bar item's title
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        
        // Adjust the text position (optional)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 15, y: -10 , width: self.tabBar.bounds.width - 30, height: self.tabBar.bounds.height + 20), cornerRadius: 15).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 1
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor
        self.tabBar.layer.insertSublayer(layer, at: 0)
    }
    
}

extension MyTabBar{
    func driverCountNotiApiMethod(){
        let param = [String:Any]()
        NotificationViewModel.countNotificationApi(viewController: self, parameters: param as NSDictionary ){(response) in
            print("success")
            self.driverCountNotiModel = response
            let count = "\(self.driverCountNotiModel?.count ?? 0)"
            guard let viewControllers = self.viewControllers, viewControllers.count > 3 else {
                return
            }
            
            let thirdTabBarItem = viewControllers[3].tabBarItem
            thirdTabBarItem?.badgeValue = count
            if #available(iOS 10.0, *) {
                thirdTabBarItem?.badgeColor = UIColor.red
            }
           
        }
    }
}
