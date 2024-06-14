//
//  AddtionalServiceModel.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 13/06/24.
//

import Foundation

struct AddtioalServiceModel:Codable {
    var status:String?
    var msg:String?
    var data:[AddtioalServiceDataModel]?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent([AddtioalServiceDataModel].self, forKey: .data)
       
     }
    
}

struct AddtioalServiceDataModel:Codable {
      var id:Int?
    var additional_type:String?
    
    
    enum CodingKeys:String,CodingKey{
        case id = "id"
        case additional_type = "additional_type"
      
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.additional_type = try container.decodeIfPresent(String.self, forKey: .additional_type)
        
       
     }
    
}

