//
//  UpdareProfileModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 06/05/24.
//

import Foundation
struct UpdareProfileModel:Codable{
 
    var status:String?
    var msg:String?

    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
    }
}
