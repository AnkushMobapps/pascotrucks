//
//  requestOrderModel.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 17/06/24.
//

import Foundation

struct resqustOrderModel:Codable{
    var status:String?
    var msg:String?
    var data:[resqustOrderDataModel]?
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent([resqustOrderDataModel].self, forKey: .data)
    }
}

struct resqustOrderDataModel:Codable{
    var id:Int?
    var booking_number:String?
    var basicprice:Double?
    var pickup_datetime:String?
    var user:String?
   
   
    enum CodingKeys:String,CodingKey{
        case id = "id"
        case booking_number = "booking_number"
        case basicprice = "basicprice"
        case pickup_datetime = "pickup_datetime"
        case user = "user"
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.booking_number = try container.decodeIfPresent(String.self, forKey: .booking_number)
        self.basicprice = try container.decodeIfPresent(Double.self, forKey: .basicprice)
        self.pickup_datetime = try container.decodeIfPresent(String.self, forKey: .pickup_datetime)
        self.user = try container.decodeIfPresent(String.self, forKey: .user)
    }
}


// MARK: All Bids Model

struct AllBidsModel:Codable{
    var status:String?
    var msg:String?
    var data:[AllBidsDataModel]?
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent([AllBidsDataModel].self, forKey: .data)
    }
}

struct AllBidsDataModel:Codable{
    var id:Int?
    var booking_number:String?
    var basicprice:Double?
    var pickup_datetime:String?
    var user:String?
   
   
    enum CodingKeys:String,CodingKey{
        case id = "id"
        case booking_number = "booking_number"
        case basicprice = "basicprice"
        case pickup_datetime = "pickup_datetime"
        case user = "user"
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.booking_number = try container.decodeIfPresent(String.self, forKey: .booking_number)
        self.basicprice = try container.decodeIfPresent(Double.self, forKey: .basicprice)
        self.pickup_datetime = try container.decodeIfPresent(String.self, forKey: .pickup_datetime)
        self.user = try container.decodeIfPresent(String.self, forKey: .user)
    }
}


// MARK: Accept order Model

struct ActiveOrderModel:Codable{
    var status:String?
    var msg:String?
    var data:[ActiveOrdeDataModel]?
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent([ActiveOrdeDataModel].self, forKey: .data)
    }
}

struct ActiveOrdeDataModel:Codable{
    var id:Int?
    var booking_number:String?
    var basicprice:Double?
    var pickup_datetime:String?
    var user:String?
   
   
    enum CodingKeys:String,CodingKey{
        case id = "id"
        case booking_number = "booking_number"
        case basicprice = "basicprice"
        case pickup_datetime = "pickup_datetime"
        case user = "user"
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.booking_number = try container.decodeIfPresent(String.self, forKey: .booking_number)
        self.basicprice = try container.decodeIfPresent(Double.self, forKey: .basicprice)
        self.pickup_datetime = try container.decodeIfPresent(String.self, forKey: .pickup_datetime)
        self.user = try container.decodeIfPresent(String.self, forKey: .user)
    }
}
