//
//  TitleBar.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 22/04/24.
//

import UIKit



class TitleBar: UIView {

    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var driverImg: UIImageView!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var switchCondition: UISwitch!
    @IBOutlet weak var countOfNotification: UILabel!
    
    override init(frame: CGRect ){
        super.init(frame: frame)
        commitinit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        commitinit()
    }
    
    private func commitinit(){
        Bundle.main.loadNibNamed("TitleBar", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }


}
