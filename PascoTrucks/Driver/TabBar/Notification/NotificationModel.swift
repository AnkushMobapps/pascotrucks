//
//  NotificationModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 18/05/24.
//

import Foundation

//show notification model
struct ShowNotificationModel:Codable{
    var status:String?
    var msg:String?
    var data:[ShowNotificationModel_data]?
   
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent([ShowNotificationModel_data].self, forKey: .data)
    }
}
struct ShowNotificationModel_data:Codable{
    var id:Int?
    var recipient:String?
    var sender:String?
    var notification_title:String?
    var notification_description:String?
    var reader:Bool?
    var created_at:String?
  
    enum CodingKeys:String,CodingKey{
        case id = "id"
        case recipient = "recipient"
        case sender = "sender"
        case notification_title = "notification_title"
        case notification_description = "notification_description"
        case reader = "reader"
        case created_at = "created_at"
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.recipient = try container.decodeIfPresent(String.self, forKey: .recipient)
        self.sender = try container.decodeIfPresent(String.self, forKey: .sender)
        self.notification_title = try container.decodeIfPresent(String.self, forKey: .notification_title)
        self.notification_description = try container.decodeIfPresent(String.self, forKey: .notification_description)
        self.reader = try container.decodeIfPresent(Bool.self, forKey: .reader)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
    }

}

// count notification model
struct CountNotificationModel:Codable{
    var status:String?
    var msg:String?
    var count:Int?
   
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case count = "count"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
    }
    
}
// delet perticular notification model
struct DeletePerticularNotifiModel:Codable{
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
// clear All notification model
struct ClearAllNotifiModel:Codable{
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
