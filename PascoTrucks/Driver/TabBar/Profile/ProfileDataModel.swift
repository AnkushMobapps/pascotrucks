//
//  ProfileDataModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 04/05/24.
//

import Foundation
//{
//    "status": "True",
//    "msg": "User Profile Details",
//    "data": {
//        "id": 2,
//        "full_name": "sukku",
//        "email": "sukku@gmail.com",
//        "phone_number": "9305253432",
//        "image": "/media/media/80_fYRY5JL.png",
//        "user_type": "user",
//        "current_city": "noidafdfd"
//    }
//}
struct ProfileDataModel : Codable{
    var status:String?
    var msg:String?
    var data:ProfileDataModel_data?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent(ProfileDataModel_data.self, forKey: .data)
    }
}

struct ProfileDataModel_data : Codable{
    var id:Int?
    var phone_number:String?
    var full_name:String?
    var email:String?
    var image:String?
    var current_city:String?
    var user_type:String?
    
    enum CodingKeys:String,CodingKey{
        
        case id = "id"
        case phone_number = "phone_number"
        case full_name = "full_name"
        case email = "email"
        case image = "image"
        case current_city = "current_city"
        case user_type = "user_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.phone_number = try container.decodeIfPresent(String.self, forKey: .phone_number)
        self.full_name = try container.decodeIfPresent(String.self, forKey: .full_name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.current_city = try container.decodeIfPresent(String.self, forKey: .current_city)
        self.user_type = try container.decodeIfPresent(String.self, forKey: .user_type)
    }
}
