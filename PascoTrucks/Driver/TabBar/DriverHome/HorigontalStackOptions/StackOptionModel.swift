//
//  StackOptionModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 10/06/24.
//

import Foundation

struct driverNoteModel:Codable{
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
