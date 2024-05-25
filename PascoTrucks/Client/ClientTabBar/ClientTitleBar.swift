//
//  ClientTitleBar.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 13/05/24.
//

import UIKit

class ClientTitleBar: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientImg: UIImageView!
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var ClientNoItem: UILabel!
    
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
        Bundle.main.loadNibNamed("ClientTitleBar", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
}
