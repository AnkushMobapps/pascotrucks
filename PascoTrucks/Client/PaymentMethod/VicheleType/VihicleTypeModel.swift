//
//  VihicleTypeModel.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 13/06/24.
//

import Foundation


struct VehichleTypeModel:Codable {
    var status:String?
    var msg:String?
    var data:[VehichleTypeDataModel]?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent([VehichleTypeDataModel].self, forKey: .data)
       
     }
    
}

struct VehichleTypeDataModel:Codable {
      var id:Int?
    var vehiclename:String?
    
    
    enum CodingKeys:String,CodingKey{
        case id = "id"
        case vehiclename = "vehiclename"
      
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.vehiclename = try container.decodeIfPresent(String.self, forKey: .vehiclename)
        
       
     }
    
}

