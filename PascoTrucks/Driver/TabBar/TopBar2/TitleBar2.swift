//
//  TitleBar2.swift
//  PascoTrucks
//
//  Created by Deepanshu Sharma on 24/04/24.
//

import UIKit

class TitleBar2: UIView {

    @IBOutlet var container: UIView!
    @IBOutlet weak var titleName: UILabel!
    
    override init(frame:CGRect){
        super.init(frame:frame )
        commit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder )
        commit()
    }
    private func commit(){
        Bundle.main.loadNibNamed("TitleBar2", owner: self, options: nil)
        addSubview(container)
        container.frame = self.bounds
        container.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleName.font = UIFont(name: "DMSans-Bold-BF64376d32191f2", size: 15.0)
        
    }
  
   @IBAction func backBtnPress(_ sender: UIButton) {
       print("hello")


    }
    
    
    
}
