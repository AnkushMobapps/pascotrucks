//
//  ClientProfileModel.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 12/06/24.
//

import Foundation
struct ClientProfileModel:Codable {
    var status:String?
    var msg:String?
    var profile:Int?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case profile = "profile"
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.profile = try container.decodeIfPresent(Int.self, forKey: .profile)
       
     }
    
}


// MARK: - Get Profile Data


struct GetProfileModel:Codable {
    var status:String?
    var msg:String?
    var data:GetProfileDataModel?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent(GetProfileDataModel.self, forKey: .data)
       
     }
    
}

struct GetProfileDataModel:Codable {
    var full_name:String?
    var email:String?
    var phone_number:String?
    var image:String?
    var user_type:String?
    var current_city:String?
    var id:Int?
    
    enum CodingKeys:String,CodingKey{
        case full_name = "full_name"
        case email = "email"
        case phone_number = "phone_number"
        case image = "image"
        case user_type = "user_type"
        case current_city = "current_city"
        case id = "id"
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.full_name = try container.decodeIfPresent(String.self, forKey: .full_name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.phone_number = try container.decodeIfPresent(String.self, forKey: .phone_number)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.user_type = try container.decodeIfPresent(String.self, forKey: .user_type)
        self.current_city = try container.decodeIfPresent(String.self, forKey: .current_city)
       
     }
    
}

