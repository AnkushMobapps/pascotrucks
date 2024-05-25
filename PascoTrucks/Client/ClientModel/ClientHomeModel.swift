//
//  ClientHomeModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 16/05/24.
//

import Foundation
struct ClientServiceModel:Codable{
    var status:String?
    var msg:String?
    var data:[ClientServiceModel_data]?
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent([ClientServiceModel_data].self, forKey: .data)
    }
}

struct ClientServiceModel_data:Codable{
    var id:Int?
    var shipmentname:String?
    var shipmentimage:String?
    var shipmentdescription:String?
   
    enum CodingKeys:String,CodingKey{
        case id = "id"
        case shipmentname = "shipmentname"
        case shipmentimage = "shipmentimage"
        case shipmentdescription = "shipmentdescription"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.shipmentname = try container.decodeIfPresent(String.self, forKey: .shipmentname)
        self.shipmentimage = try container.decodeIfPresent(String.self, forKey: .shipmentimage)
        self.shipmentdescription = try container.decodeIfPresent(String.self, forKey: .shipmentdescription)
       
    }
}
    

