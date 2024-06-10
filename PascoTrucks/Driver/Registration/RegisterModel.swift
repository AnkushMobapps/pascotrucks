//
//  RegisterModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 04/05/24.
//

import Foundation

//select city on behalf of country code model

struct SelectCityModel:Codable{
    var status:String?
    var msg:String?
    var data:[SelectCityModel_data]?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
  
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decode([SelectCityModel_data].self, forKey: .data)
    }
}
struct SelectCityModel_data:Codable{
    var countrycode:String?
    var countryname:String?
    var cityname:String?
    
    enum CodingKeys:String,CodingKey{
        case countrycode = "countrycode"
        case countryname = "countryname"
        case cityname = "cityname"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.countrycode = try container.decodeIfPresent(String.self, forKey: .countrycode)
        self.countryname = try container.decodeIfPresent(String.self, forKey: .countryname)
        self.cityname = try container.decodeIfPresent(String.self, forKey: .cityname)
    }
 }


//chek no is register or not model
struct ChekRegisterNUmberModel:Codable{
    var status:String?
    var msg:String?
    var exists:Int
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case exists = "exists"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.exists = try container.decode(Int.self, forKey: .exists)
    }
}

//driver register model

struct DriverRegisterModel : Codable{
    var status:String?
    var msg:String?
    var data:RegisterModel_data?
    var token:TokenDict?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
        case token = "token"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.token = try container.decodeIfPresent(TokenDict.self, forKey: .token)
        self.data = try container.decodeIfPresent(RegisterModel_data.self, forKey: .data)
    }
}

struct TokenDict : Codable{
    var refresh:String?
    var access:String?
    enum CodingKeys: CodingKey {
        case refresh
        case access
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.refresh = try container.decodeIfPresent(String.self, forKey: .refresh)
        self.access = try container.decodeIfPresent(String.self, forKey: .access)
    }
}


struct RegisterModel_data : Codable{
    var user_type:String?
    var phone_number:String?
    var full_name:String?
    var email:String?
    var current_location:String?
    var current_city:String?
    var phone_verify:String?
    var current_latitude:String?
    var current_longitude:String?
    
    
    enum CodingKeys:String,CodingKey{
        
        case user_type = "user_type"
        case phone_number = "phone_number"
        case full_name = "full_name"
        case email = "email"
        case current_location = "current_location"
        case current_city = "address"
        case phone_verify = "phone_verify"
        case current_latitude = "current_latitude"
        case current_longitude = "current_longitude"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user_type = try container.decodeIfPresent(String.self, forKey: .user_type)
        self.phone_number = try container.decodeIfPresent(String.self, forKey: .phone_number)
        self.full_name = try container.decodeIfPresent(String.self, forKey: .full_name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.current_location = try container.decodeIfPresent(String.self, forKey: .current_location)
        self.current_city = try container.decodeIfPresent(String.self, forKey: .current_city)
        self.phone_verify = try container.decodeIfPresent(String.self, forKey: .phone_verify)
        self.current_latitude = try container.decodeIfPresent(String.self, forKey: .current_latitude)
        self.current_longitude = try container.decodeIfPresent(String.self, forKey: .current_longitude)
    }
}



//  MARK: - Client Registration ViewModel


struct ClientRegisterModel : Codable{
    var status:String?
    var msg:String?
    var data:ClientRegisterModel_data?
    var token:ClientTokenDict?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
        case token = "token"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.token = try container.decodeIfPresent(ClientTokenDict.self, forKey: .token)
        self.data = try container.decodeIfPresent(ClientRegisterModel_data.self, forKey: .data)
    }
}

struct ClientTokenDict : Codable{
    var refresh:String?
    var access:String?
    enum CodingKeys: CodingKey {
        case refresh
        case access
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.refresh = try container.decodeIfPresent(String.self, forKey: .refresh)
        self.access = try container.decodeIfPresent(String.self, forKey: .access)
    }
}


struct ClientRegisterModel_data : Codable{
    var user_type:String?
    var phone_number:String?
    var user_id:Int?
   
    
    
    enum CodingKeys:String,CodingKey{
        
        case user_type = "user_type"
        case phone_number = "phone_number"
        case user_id = "user_id"
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user_type = try container.decodeIfPresent(String.self, forKey: .user_type)
        self.phone_number = try container.decodeIfPresent(String.self, forKey: .phone_number)
        self.user_id = try container.decodeIfPresent(Int.self, forKey: .user_id)
       
    }
}
