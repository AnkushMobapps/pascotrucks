//
//  PaymentmethodModel.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 13/06/24.
//

import Foundation

struct PaymentMethodModel:Codable {
    var status:String?
    var msg:String?
    var available_driver:Int?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case available_driver = "available_driver"
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.available_driver = try container.decodeIfPresent(Int.self, forKey: .available_driver)
       
     }
    
}



// MARK: cargoQty Model

struct CargoQtyModel:Codable {
    var status:String?
    var msg:String?
    var available_driver:Int?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case available_driver = "available_driver"
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.available_driver = try container.decodeIfPresent(Int.self, forKey: .available_driver)
       
     }
    
}



// MARK: Chek Charges Model

struct ChekChargesModel:Codable {
    var status:String?
    var msg:String?
    var servicename:String?
    var cargoname:String?
    var cargoimage:String?
    var distance:Double?
    var price:Double?
    var pickup_location:String?
    var drop_location:String?
    var duration:ChekChargesDataModel?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case servicename = "servicename"
        case cargoname = "cargoname"
        case cargoimage = "cargoimage"
        case distance = "distance"
        case price = "price"
        case pickup_location = "pickup_location"
        case drop_location = "drop_location"
        case duration = "duration"
     
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.servicename = try container.decodeIfPresent(String.self, forKey: .servicename)
        self.cargoname = try container.decodeIfPresent(String.self, forKey: .cargoname)
        self.cargoimage = try container.decodeIfPresent(String.self, forKey: .cargoimage)
        self.distance = try container.decodeIfPresent(Double.self, forKey: .distance)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        self.pickup_location = try container.decodeIfPresent(String.self, forKey: .pickup_location)
        self.drop_location = try container.decodeIfPresent(String.self, forKey: .drop_location)
        self.duration = try container.decodeIfPresent(ChekChargesDataModel.self, forKey: .duration)
        
       
     }
    
}


struct ChekChargesDataModel:Codable {
    var hours:Int?
    var minutes:Int?
   
    enum CodingKeys:String,CodingKey{
        case hours = "hours"
        case minutes = "minutes"
   
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.hours = try container.decodeIfPresent(Int.self, forKey: .hours)
        self.minutes = try container.decodeIfPresent(Int.self, forKey: .minutes)
      
     
     }
    
}
