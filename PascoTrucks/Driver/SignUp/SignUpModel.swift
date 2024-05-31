//
//  SignUpModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 29/04/24.
//

import Foundation
//struct SignUpModel : Codable{
//    var status:String?
//    var msg:String?
//    var data:SignUpModel_data?
//    
//    enum CodingKeys:String,CodingKey{
//        case status = "status"
//        case msg = "msg"
//        case data = "data"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.status = try container.decodeIfPresent(String.self, forKey: .status)
//        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
//        self.data = try container.decodeIfPresent(SignUpModel_data.self, forKey: .data)
//    }
//}
//
//struct SignUpModel_data : Codable{
//    var user_type:String?
//    var phone_number:String?
//    var full_name:String?
//    var email:String?
//    var image:String?
//    var address:String?
//    var phone_verify:String?
//    
//    
//    enum CodingKeys:String,CodingKey{
//        
//        case user_type = "user_type"
//        case phone_number = "phone_number"
//        case full_name = "full_name"
//        case email = "email"
//        case image = "image"
//        case address = "address"
//        case phone_verify = "phone_verify"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.user_type = try container.decodeIfPresent(String.self, forKey: .user_type)
//        self.phone_number = try container.decodeIfPresent(String.self, forKey: .phone_number)
//        self.full_name = try container.decodeIfPresent(String.self, forKey: .full_name)
//        self.email = try container.decodeIfPresent(String.self, forKey: .email)
//        self.image = try container.decodeIfPresent(String.self, forKey: .image)
//        self.address = try container.decodeIfPresent(String.self, forKey: .address)
//        self.phone_verify = try container.decodeIfPresent(String.self, forKey: .phone_verify)
//    }
//}

//For Driver Registration
//{
//    "status": "False",
//    "msg": "Phone Number Not Registered"
//}

//struct ChekRegisterNUmberModel:Codable{
//    var status:String?
//    var msg:String?
//    var exists:Int
//    
//    enum CodingKeys:String,CodingKey{
//        case status = "status"
//        case msg = "msg"
//        case exists = "exists"
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.status = try container.decodeIfPresent(String.self, forKey: .status)
//        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
//        self.exists = try container.decode(Int.self, forKey: .exists)
//    }
//}

//// for client register model
struct CRegisterModel:Codable{
    var status:String?
    var msg:String?
    var data:CRegisterModel_data?
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
      }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent(CRegisterModel_data.self, forKey: .data)
    }

    struct CRegisterModel_data:Codable{

        var user_type:String?
        var phone_verify:String?
        var phone_number:String?

        enum CodingKeys:String,CodingKey{
           case user_type = "user_type"
            case phone_verify = "phone_verify"
            case phone_number = "phone_number"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.user_type = try container.decodeIfPresent(String.self, forKey: .user_type)
            self.phone_verify = try container.decodeIfPresent(String.self, forKey: .phone_verify)
            self.phone_number = try container.decode(String.self, forKey: .phone_number)
        }
    }

}
