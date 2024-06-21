//
//  DriverNotesModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 11/06/24.
//

import Foundation

//driver Notes Model
struct DriverNoteModel:Codable{
    var status:String?
    var msg:String?
   
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
    }
 }

//get Note model
struct DriverGetNotesModel:Codable{
    var status:String?
    var msg:String?
    var data:[driverGetNotesModel_data]?
   
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent([driverGetNotesModel_data].self, forKey: .data)
    }
    
 }

struct driverGetNotesModel_data:Codable{
    var id:Int?
    var user:String?
    var title:String?
    var description:String?
    var reminderdate:String?
  
    
    enum CodingKeys:String,CodingKey{
        case id = "id"
        case user = "user"
        case title = "title"
        case description = "description"
        case reminderdate = "reminderdate"
   }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.user = try container.decodeIfPresent(String.self, forKey: .user)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.reminderdate = try container.decodeIfPresent(String.self, forKey: .reminderdate)
    }
  
    
 }

//delet note model
/*
 {
     "status": "True",
     "message": "Note delete successfully!.."
 }
 */

struct driverDeleteNoteModel:Codable{
    var status:String?
    var message:String?
   
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case message = "message"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
    }
 }
