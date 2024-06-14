//
//  LoginModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 29/04/24.
//
import Foundation

//for driver
struct CheckLoginModel:Codable{

    var status:String?
    var msg:String?
    var login:Int?
    
    enum CodingKeys:String,CodingKey{
       case status = "status"
        case msg = "msg"
        case login = "Login"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.login = try container.decodeIfPresent(Int.self, forKey: .login)
    }
}

struct LoginModel:Codable{
    var status:String?
    var msg:String?
    var token : TokennDict?
    var user_id:Int?
//    var phone_number:String?
    var user_type:String?
    var email:String?
    var full_name:String?
    var address:String?
    var approved:Int?
    
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case token = "token"
        case user_id = "user_id"
        case user_type = "user_type"
//        case phone_number = "phone_number"
        case email = "email"
        case full_name = "full_name"
        case address = "address"
        case approved = "approved"
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.token = try container.decodeIfPresent(TokennDict.self, forKey: .token)
        self.user_id = try container.decodeIfPresent(Int.self, forKey: .user_id)
        self.user_type = try container.decodeIfPresent(String.self, forKey: .user_type)
//        self.phone_number = try container.decodeIfPresent(String.self, forKey: .phone_number)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
        self.full_name = try container.decodeIfPresent(String.self, forKey: .full_name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.approved = try container.decodeIfPresent(Int.self, forKey: .approved)
    }
}

struct TokennDict : Codable{
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


//driver other device login model
struct DriverUpdateDeviceLoginModel:Codable{

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

//driver logout

struct DriverLogOutModel:Codable{
   var Status:String?
    var msg:String?
  
    enum CodingKeys:String,CodingKey{
       case Status = "Status"
        case msg = "msg"
       
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.Status = try container.decodeIfPresent(String.self, forKey: .Status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
    }
}


//client checkLogin model
struct CheckClientLoginModel:Codable{

    var status:String?
    var msg:String?
    var Login:Int
    
    enum CodingKeys:String,CodingKey{
       case status = "status"
        case msg = "msg"
        case Login = "Login"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.Login = try container.decodeIfPresent(Int.self, forKey: .Login) ?? 00
    }
}

// client login model
struct ClientLoginModel:Codable{
    var status:String?
    var msg:String?
    var user_id:Int?
    var phone_number:String?
    var profile:Int?
    var token:ClientToken?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case user_id = "user_id"
        case phone_number = "phone_number"
        case profile = "profile"
        case token = "token"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.user_id = try container.decodeIfPresent(Int.self, forKey: .user_id)
        self.phone_number = try container.decodeIfPresent(String.self, forKey: .phone_number)
        self.profile = try container.decodeIfPresent(Int.self, forKey: .profile)
        self.token = try container.decodeIfPresent(ClientToken.self, forKey: .token)
     }
    
}

struct ClientToken : Codable{
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






 //client other device login model
struct ClientUpdateDeviceLoginModel:Codable{

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
