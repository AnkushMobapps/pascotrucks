//
//  OrderDetailsModel.swift
//  PascoTrucks
//
//  Created by Deepanshu Mac on 18/06/24.
//

import Foundation

struct OrderdetailsModel:Codable{
    var status:String?
    var msg:String?
    var data:[OrderdetailsDataModel]?
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent([OrderdetailsDataModel].self, forKey: .data)
    }
}

struct OrderdetailsDataModel:Codable{
    var id:Int?
    var booking_number:String?
    var basicprice:Double?
    var pickup_datetime:String?
    var driver:String?
    var total_distance:Double?
    var pickup_location:String?
    var drop_location:String?
    var bid_price:Double?
    var upfront_payment:Double?
    var driver_image:String?
   
   
    enum CodingKeys:String,CodingKey{
        case id = "id"
        case booking_number = "booking_number"
        case basicprice = "basicprice"
        case pickup_datetime = "pickup_datetime"
        case driver = "driver"
        case total_distance = "total_distance"
        case pickup_location = "pickup_location"
        case drop_location = "drop_location"
        case bid_price = "bid_price"
        case upfront_payment = "upfront_payment"
        case driver_image = "driver_image"
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.booking_number = try container.decodeIfPresent(String.self, forKey: .booking_number)
        self.basicprice = try container.decodeIfPresent(Double.self, forKey: .basicprice)
        self.pickup_datetime = try container.decodeIfPresent(String.self, forKey: .pickup_datetime)
        self.driver = try container.decodeIfPresent(String.self, forKey: .driver)
        self.total_distance = try container.decodeIfPresent(Double.self, forKey: .total_distance)
        self.pickup_location = try container.decodeIfPresent(String.self, forKey: .pickup_location)
        self.drop_location = try container.decodeIfPresent(String.self, forKey: .drop_location)
        self.bid_price = try container.decodeIfPresent(Double.self, forKey: .bid_price)
        self.upfront_payment = try container.decodeIfPresent(Double.self, forKey: .upfront_payment)
        self.driver_image = try container.decodeIfPresent(String.self, forKey: .driver_image)
    }
}


    // MARK: Assign Booking Modeel

struct AssignBookingModel:Codable{
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
