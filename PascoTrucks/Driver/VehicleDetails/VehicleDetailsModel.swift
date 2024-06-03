//
//  VehicleDetailsModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 01/05/24.
//

import Foundation
//transporter list model
struct TransporterModel: Codable{

    var status:String?
    var msg:String?
    var data:[TransporterModel_data]?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
      
 }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent([TransporterModel_data].self, forKey: .data)
        
    }
}


struct TransporterModel_data:Codable{
   
    var shipmentid:Int?
    var shipmentname:String?
    var shipmentdescription:String?
    
    enum CodingKeys:String,CodingKey{
        case shipmentid = "shipmentid"
        case shipmentname = "shipmentname"
        case shipmentdescription = "shipmentdescription"
  }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.shipmentid = try container.decodeIfPresent(Int.self, forKey: .shipmentid)
        self.shipmentname = try container.decodeIfPresent(String.self, forKey: .shipmentname)
        self.shipmentdescription = try container.decodeIfPresent(String.self, forKey: .shipmentdescription)
        
    }
    
}

// MARK: - vehicle list model

struct VehicleModel:Codable{
    var status:String?
    var msg:String?
    var data:[VehicleModel_data]?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
      }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent([VehicleModel_data].self, forKey: .data)
       }
}

struct VehicleModel_data:Codable{
    var id:Int?
    var shipmentname:String?
    var vehiclename:String?
    
    
    enum CodingKeys:String,CodingKey{
        case id = "id"
        case shipmentname = "shipmentname"
        case vehiclename = "vehiclename"
        
      }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.shipmentname = try container.decodeIfPresent(String.self, forKey: .shipmentname)
        self.vehiclename = try container.decodeIfPresent(String.self, forKey: .vehiclename)
    }
}

//country list model
struct CountryListModel: Codable{
    var status:String?
    var msg:String?
    var data:[CountryListModel_data]?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
  }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent([CountryListModel_data].self, forKey: .data)
        
}
}


struct CountryListModel_data:Codable{
    var id:Int?
    var countryname:String?
    
    enum CodingKeys:String,CodingKey
    {
        case id = "id"
        case countryname = "countryname"
    }
   
    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.countryname = try container.decodeIfPresent(String.self, forKey: .countryname)
   }
    
}

//city list model
struct CityListModel: Codable{
   var status:String?
    var msg:String?
    var data:[CityListModel_data]?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
   }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent([CityListModel_data].self, forKey: .data)
    }
}
struct CityListModel_data:Codable{
    var id:Int?
    var countryname:String?
    var cityname:String?
    
    enum CodingKeys:String,CodingKey{
         case id = "id"
        case countryname = "countryname"
        case cityname = "cityname"
      
 }
 init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.countryname = try container.decodeIfPresent(String.self, forKey: .countryname)
        self.cityname = try container.decodeIfPresent(String.self, forKey: .cityname)
        
}
}

//Approval Model
struct ApprovalModel:Codable{
    var status:String?
    var msg:String?
    var data:ApprovalModel_Data?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent(ApprovalModel_Data.self, forKey: .data)
        
    }
}

struct ApprovalModel_Data:Codable{
    var user:String?
    var cargo:String?
    var vehicle_photo:String?
    var document:String?
    var driving_license:String?
    var vehiclenumber:String?
    
enum CodingKeys:String,CodingKey{
        case user = "user"
        case cargo = "cargo"
        case vehicle_photo = "vehicle_photo"
        case document = "document"
        case driving_license = "driving_license"
        case vehiclenumber = "vehiclenumber"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decodeIfPresent(String.self, forKey: .user)
        self.cargo = try container.decodeIfPresent(String.self, forKey: .cargo)
        self.vehicle_photo = try container.decodeIfPresent(String.self, forKey: .vehicle_photo)
        self.document = try container.decodeIfPresent(String.self, forKey: .document)
        self.driving_license = try container.decodeIfPresent(String.self, forKey: .driving_license)
        self.vehiclenumber = try container.decodeIfPresent(String.self, forKey: .vehiclenumber)
    }
}

// vehicle Data show model
struct vehicleApprove:Codable{
    var status:String?
    var msg:String?
    var data:GetVehicleDataModel?

    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent(GetVehicleDataModel.self, forKey: .data)
    }
}
struct GetVehicleDataModel:Codable{
    var status:String?
    var msg:String?
    var id:Int?
    var user:String?
    var shipmentname:String?
    var vehiclename:String?
    var vehiclenumber:String?
    var vehicle_photo:String?
    var document:String?
    var driving_license:String?
    var approval_status:String?
    var comment:String?
    var cargo:Int?
    var shipmentid:Int?
    
    
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case  id = "id"
        case  user = "user"
        case  shipmentname = "shipmentname"
        case  vehiclename = "vehiclename"
        case  vehiclenumber = "vehiclenumber"
        case  vehicle_photo = "vehicle_photo"
        case  document = "document"
        case  driving_license = "driving_license"
        case  approval_status = "approval_status"
        case  comment = "comment"
        case cargo = "cargo"
        case shipmentid = "shipmentid"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.user = try container.decodeIfPresent(String.self, forKey: .user)
        self.shipmentname = try container.decodeIfPresent(String.self, forKey: .shipmentname)
        self.vehiclename = try container.decodeIfPresent(String.self, forKey: .vehiclename)
        self.vehiclenumber = try container.decodeIfPresent(String.self, forKey: .vehiclenumber)
        self.vehicle_photo = try container.decodeIfPresent(String.self, forKey: .vehicle_photo)
        self.document = try container.decodeIfPresent(String.self, forKey: .document)
        self.driving_license = try container.decodeIfPresent(String.self, forKey: .driving_license)
        self.approval_status = try container.decodeIfPresent(String.self, forKey: .approval_status)
        self.cargo = try container.decodeIfPresent(Int.self, forKey: .cargo)
        self.shipmentid = try container.decodeIfPresent(Int.self, forKey: .shipmentid)
        self.comment = try container.decodeIfPresent(String.self, forKey: .comment)
    }
    
}

// vehicle data update model

struct UpdareVehicleDataModel:Codable{
 
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
