//
//  HistoryModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 12/06/24.
//

import Foundation

// show complete order model
struct DriverShowCompleteOrderModel:Codable{
    var status:String?
    var msg:String?
    var data:[DriverShowCompleteOrderModel_data]
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decode([DriverShowCompleteOrderModel_data].self, forKey: .data)
    }
    
}
struct DriverShowCompleteOrderModel_data:Codable{
    var id:Int?
    var booking_number:String?
    var user:String?
    var user_image:String?
    var driver:String?
    var driver_image:String?
    var shipmentname:String?
    
    var vehiclename:String?
    var pickup_location:String?
    var pickup_latitude:Double?
    var pickup_longitude:Double?
    var drop_location:String?
    var drop_latitude:Double?
    
    var drop_longitude:Double?
    var total_distance:Double?
    var duration:Int?
    var basicprice:Double?
    var booking_status:String?
    var payment_status:String?
    var pickup_datetime:String?
    var commision_price:Double?
    var message:String?
    var payment_method:String?
    var customer_status:String?
    var additionalservice_name:String?
    var additionalservice_amount:Int?
    var created_at:String?
    var availability_datetime:String?
    var bid_price:Double?
    
    
    
enum CodingKeys:String,CodingKey{
        case id = "id"
        case booking_number = "booking_number"
        case user = "user"
        case user_image = "user_image"
        case driver = "driver"
        case driver_image = "driver_image"
        case shipmentname = "shipmentname"
        case vehiclename = "vehiclename"
        case pickup_location = "pickup_location"
        case pickup_latitude = "pickup_latitude"
        case pickup_longitude = "pickup_longitude"
        case drop_location = "drop_location"
        case drop_latitude = "drop_latitude"
        case drop_longitude = "drop_longitude"
        case total_distance = "total_distance"
        case duration = "duration"
        case customer_status = "customer_status"
        case payment_status = "payment_status"
        case booking_status = "booking_status"
        case pickup_datetime = "pickup_datetime"
        case created_at = "created_at"
        case basicprice = "basicprice"
        case commision_price = "commision_price"
        case message = "message"
        case payment_method = "payment_method"
        case availability_datetime = "availability_datetime"
        case bid_price = "bid_price"
        case additionalservice_name = "additionalservice_name"
        case additionalservice_amount = "additionalservice_amount"
   }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.booking_number = try container.decodeIfPresent(String.self, forKey: .booking_number)
        self.user = try container.decodeIfPresent(String.self, forKey: .user)
        self.user_image = try container.decodeIfPresent(String.self, forKey: .user_image)
        self.driver = try container.decodeIfPresent(String.self, forKey: .driver)
        self.driver_image = try container.decodeIfPresent(String.self, forKey: .driver_image)
        self.shipmentname = try container.decodeIfPresent(String.self, forKey: .shipmentname)
        self.vehiclename = try container.decodeIfPresent(String.self, forKey: .vehiclename)
        self.pickup_location = try container.decodeIfPresent(String.self, forKey: .pickup_location)
        self.pickup_latitude = try container.decodeIfPresent(Double.self, forKey: .pickup_latitude)
        self.pickup_longitude = try container.decodeIfPresent(Double.self, forKey: .pickup_longitude)
        self.drop_location = try container.decodeIfPresent(String.self, forKey: .drop_location)
        self.drop_latitude = try container.decodeIfPresent(Double.self, forKey: .drop_latitude)
        self.drop_longitude = try container.decodeIfPresent(Double.self, forKey: .drop_longitude)
        self.total_distance = try container.decodeIfPresent(Double.self, forKey: .total_distance)
        self.duration = try container.decodeIfPresent(Int.self, forKey: .duration)
        self.customer_status = try container.decodeIfPresent(String.self, forKey: .customer_status)
        self.payment_status = try container.decodeIfPresent(String.self, forKey: .payment_status)
        self.booking_status = try container.decodeIfPresent(String.self, forKey: .booking_status)
        self.pickup_datetime = try container.decodeIfPresent(String.self, forKey: .pickup_datetime)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.basicprice = try container.decodeIfPresent(Double.self, forKey: .basicprice)
        self.commision_price = try container.decodeIfPresent(Double.self, forKey: .commision_price)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.payment_method = try container.decodeIfPresent(String.self, forKey: .payment_method)
        
        self.availability_datetime = try container.decodeIfPresent(String.self, forKey: .availability_datetime)
        self.bid_price = try container.decodeIfPresent(Double.self, forKey: .bid_price)
        
        self.additionalservice_name = try container.decodeIfPresent(String.self, forKey: .additionalservice_name)
        self.additionalservice_amount = try container.decodeIfPresent(Int.self, forKey: .additionalservice_amount)
    }
    

}

// show cancel order model

struct DriverShowCancelOrderModel:Codable{
    var status:String?
    var msg:String?
    var data:[DriverShowCancelOrderModel_data]
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decode([DriverShowCancelOrderModel_data].self, forKey: .data)
    }
    
}

 struct DriverShowCancelOrderModel_data:Codable{
    var id:Int?
    var booking_number:String?
    var user:String?
    var user_image:String?
    var driver:String?
    var driver_image:String?
    var shipmentname:String?
    
    var vehiclename:String?
    var pickup_location:String?
    var pickup_latitude:Double?
    var pickup_longitude:Double?
    var drop_location:String?
    var drop_latitude:Double?
    
    var drop_longitude:Double?
    var total_distance:Double?
    var duration:Int?
    var basicprice:Double?
    var booking_status:String?
    var payment_status:String?
    var pickup_datetime:String?
    var commision_price:Double?
    var message:String?
    var payment_method:String?
    var customer_status:String?
    var additionalservice_name:String?
    var additionalservice_amount:Int?
    var created_at:String?
    var availability_datetime:String?
    var bid_price:Double?
     var cancelreason:String?
    
    
    
enum CodingKeys:String,CodingKey{
        case id = "id"
        case booking_number = "booking_number"
        case user = "user"
        case user_image = "user_image"
        case driver = "driver"
        case driver_image = "driver_image"
        case shipmentname = "shipmentname"
        case vehiclename = "vehiclename"
        case pickup_location = "pickup_location"
        case pickup_latitude = "pickup_latitude"
        case pickup_longitude = "pickup_longitude"
        case drop_location = "drop_location"
        case drop_latitude = "drop_latitude"
        case drop_longitude = "drop_longitude"
        case total_distance = "total_distance"
        case duration = "duration"
        case customer_status = "customer_status"
        case payment_status = "payment_status"
        case booking_status = "booking_status"
        case pickup_datetime = "pickup_datetime"
        case created_at = "created_at"
        case basicprice = "basicprice"
        case commision_price = "commision_price"
        case message = "message"
        case payment_method = "payment_method"
        case availability_datetime = "availability_datetime"
        case bid_price = "bid_price"
        case additionalservice_name = "additionalservice_name"
        case additionalservice_amount = "additionalservice_amount"
        case cancelreason = "cancelreason"
   }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.booking_number = try container.decodeIfPresent(String.self, forKey: .booking_number)
        self.user = try container.decodeIfPresent(String.self, forKey: .user)
        self.user_image = try container.decodeIfPresent(String.self, forKey: .user_image)
        self.driver = try container.decodeIfPresent(String.self, forKey: .driver)
        self.driver_image = try container.decodeIfPresent(String.self, forKey: .driver_image)
        self.shipmentname = try container.decodeIfPresent(String.self, forKey: .shipmentname)
        self.vehiclename = try container.decodeIfPresent(String.self, forKey: .vehiclename)
        self.pickup_location = try container.decodeIfPresent(String.self, forKey: .pickup_location)
        self.pickup_latitude = try container.decodeIfPresent(Double.self, forKey: .pickup_latitude)
        self.pickup_longitude = try container.decodeIfPresent(Double.self, forKey: .pickup_longitude)
        self.drop_location = try container.decodeIfPresent(String.self, forKey: .drop_location)
        self.drop_latitude = try container.decodeIfPresent(Double.self, forKey: .drop_latitude)
        self.drop_longitude = try container.decodeIfPresent(Double.self, forKey: .drop_longitude)
        self.total_distance = try container.decodeIfPresent(Double.self, forKey: .total_distance)
        self.duration = try container.decodeIfPresent(Int.self, forKey: .duration)
        self.customer_status = try container.decodeIfPresent(String.self, forKey: .customer_status)
        self.payment_status = try container.decodeIfPresent(String.self, forKey: .payment_status)
        self.booking_status = try container.decodeIfPresent(String.self, forKey: .booking_status)
        self.pickup_datetime = try container.decodeIfPresent(String.self, forKey: .pickup_datetime)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.basicprice = try container.decodeIfPresent(Double.self, forKey: .basicprice)
        self.commision_price = try container.decodeIfPresent(Double.self, forKey: .commision_price)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.payment_method = try container.decodeIfPresent(String.self, forKey: .payment_method)
        
        self.availability_datetime = try container.decodeIfPresent(String.self, forKey: .availability_datetime)
        self.bid_price = try container.decodeIfPresent(Double.self, forKey: .bid_price)
        
        self.additionalservice_name = try container.decodeIfPresent(String.self, forKey: .additionalservice_name)
        self.additionalservice_amount = try container.decodeIfPresent(Int.self, forKey: .additionalservice_amount)
        self.cancelreason = try container.decodeIfPresent(String.self, forKey: .cancelreason)
    }
    

}



