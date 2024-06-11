//
//  DriverHomeModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 17/05/24.
//

import Foundation

//MARK:- On Off duty Model
struct MarkOnAndOffDutyModel:Codable{
    var status:String?
    var msg:String?
    var Duty:Int?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case Duty = "Duty"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.Duty = try container.decodeIfPresent(Int.self, forKey: .Duty)
    }
}


//BookingRecordListModel
struct BookingRecordListModel:Codable{
    var status:String?
    var msg:String?
    var data:[BookingRecordListModel_data]?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent([BookingRecordListModel_data].self, forKey: .data)
    }
    
}

struct BookingRecordListModel_data:Codable{
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
    var basicprice:Double?
    var commision_price:Double?
    var message:String?
    var payment_method:String?
    var customer_status:String?
    var pickup_datetime:String?
    var created_at:String?
    
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
        case basicprice = "basicprice"
        case commision_price = "commision_price"
        case message = "message"
        case payment_method = "payment_method"
        case customer_status = "customer_status"
        case pickup_datetime = "pickup_datetime"
        case created_at = "created_at"
        
    }
    
    init(from decoder: Decoder) throws {
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
        self.basicprice = try container.decodeIfPresent(Double.self, forKey: .basicprice)
        self.commision_price = try container.decodeIfPresent(Double.self, forKey: .commision_price)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.payment_method = try container.decodeIfPresent(String.self, forKey: .payment_method)
        self.customer_status = try container.decodeIfPresent(String.self, forKey: .customer_status)
        self.pickup_datetime = try container.decodeIfPresent(String.self, forKey: .pickup_datetime)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
    }
    
    
}
/*
 {
     "status": "True",
     "msg": "Booking Request Status",
     "data": {
         "id": 211,
         "booking_number": "PASCO16083240605055859376",
         "user": "Sandeep Sharma",
         "driver": "Shireen",
         "user_image": "/media/media/Screenshot_2024-05-22-17-45-48-072_com.pasco.pascocustomer_i3Ql38W.jpg",
         "driver_image": null,
         "shipmentname": "Light Transport Delivery",
         "vehiclename": "Pickup Truck",
         "pickup_location": "Block B, B35, B Block, Sector 59, Noida, Uttar Pradesh 201301, India",
         "pickup_latitude": 28.60788,
         "pickup_longitude": 77.36492,
         "drop_location": "A35, Block A, Sector 53, Noida, Uttar Pradesh 201307, India",
         "drop_latitude": 28.59231,
         "drop_longitude": 77.36382,
         "total_distance": 1.734632,
         "duration": 156,
         "basicprice": 205.4,
         "commision_price": 18.67,
         "message": "fffg",
         "payment_method": "Wallet",
         "customer_status": "pending",
         "payment_status": "unpaid",
         "pickup_datetime": "2024-06-05T17:28:00Z",
         "created_at": "2024-06-05T05:58:59.381347Z",
         "additionalservice_name": null,
         "additionalservice_amount": null,
         "availability_datetime": null,
         "bid_price": null
     }
 }
 */
struct UpdateBookingBidsModel:Codable{
    var status:String?
    var msg:String?
    var data:UpdateBookingBidsModel_data?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decodeIfPresent(UpdateBookingBidsModel_data.self, forKey: .data)
    }
    
}

struct UpdateBookingBidsModel_data:Codable{
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
    var commision_price:Double?
    var message:String?
    var payment_method:String?
    var customer_status:String?
    var payment_status:String?
    var pickup_datetime:String?
    var created_at:String?
    
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
        case basicprice = "basicprice"
        case commision_price = "commision_price"
        case message = "message"
        case payment_method = "payment_method"
        case customer_status = "customer_status"
        case payment_status = "payment_status"
        case pickup_datetime = "pickup_datetime"
        case created_at = "created_at"
        
    }
    
    init(from decoder: Decoder) throws {
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
        self.basicprice = try container.decodeIfPresent(Double.self, forKey: .basicprice)
        self.commision_price = try container.decodeIfPresent(Double.self, forKey: .commision_price)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.payment_method = try container.decodeIfPresent(String.self, forKey: .payment_method)
        self.customer_status = try container.decodeIfPresent(String.self, forKey: .customer_status)
        self.payment_status = try container.decodeIfPresent(String.self, forKey: .payment_status)
        self.pickup_datetime = try container.decodeIfPresent(String.self, forKey: .pickup_datetime)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
    }
    
    
}


struct ConfirmOrderModel:Codable{
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

/*
 {
     "status": "True",
     "msg": "Location updated successfully.."
 }
 */
struct UpdateDriverLocationModel:Codable{
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
