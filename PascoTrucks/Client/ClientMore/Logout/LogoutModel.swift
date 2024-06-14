//
//  LogoutModel.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 12/06/24.
//

import Foundation

struct LogoutModel:Codable{

    var Status:String?
    var msg:String?
  
    
    enum CodingKeys:String,CodingKey{
       case Status = "Status"
        case msg = "msg"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Status = try container.decodeIfPresent(String.self, forKey: .Status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
       
    }
}
