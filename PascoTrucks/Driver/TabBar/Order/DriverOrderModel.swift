//
//  DriverOrderModel.swift
//  PascoTrucks
//
//  Created by Narendra Kumar on 10/06/24.
//

import Foundation
/*
 {
     "status": "True",
     "msg": "Booking Bid Details",
     "data": [
         {
             "id": 262,
             "booking_number": "PASCO160103240610091456729",
             "user": "Sandeep Sharma",
             "driver": "Shireen",
             "user_image": "/media/media/Screenshot_2024-05-22-17-45-48-072_com.pasco.pascocustomer_i3Ql38W.jpg",
             "driver_image": null,
             "shipmentname": "Light Transport Delivery",
             "vehiclename": "Pickup Truck",
             "pickup_location": "6, Mahakali Caves Rd, Shanti Nagar, Andheri East, Mumbai, Maharashtra 400053, India",
             "pickup_latitude": 19.11778,
             "pickup_longitude": 72.86305,
             "drop_location": "4VP5+526, Squatters Colony Rd, Janta Nagar, Bandra Plot, Harijan Nagar Nagar, Jogeshwari East, Mumbai, Maharashtra 400060, India",
             "drop_latitude": 19.13542,
             "drop_longitude": 72.8575,
             "total_distance": 2.046304,
             "duration": 184,
             "customer_status": "pending",
             "payment_status": "unpaid",
             "booking_status": "pending",
             "pickup_datetime": "2024-06-12T16:43:00Z",
             "created_at": "2024-06-10T09:14:56.942779Z",
             "basicprice": 222.55,
             "message": "sdff",
             "payment_method": "Cash",
             "upfront_payment": 20.0,
             "availability_datetime": "2024-06-28T05:33:00Z",
             "bid_price": 200.0,
             "availabledrop_datetime": "2024-06-28T05:36:04Z",
             "additionalservice_name": null,
             "additionalservice_amount": null
         }
     ]
 }
 */
struct DriverBidingStatusModel:Codable{
    var status:String?
    var msg:String?
    var data:[DriverBidingStatusModel_data]
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decode([DriverBidingStatusModel_data].self, forKey: .data)
    }
    
}

struct DriverBidingStatusModel_data:Codable{
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
    var customer_status:String?
    var payment_status:String?
    var booking_status:String?
    var pickup_datetime:String?
    var created_at:String?
    var basicprice:Double?
    var commision_price:Double?
    var message:String?
    var payment_method:String?
    
    var upfront_payment:Double?
    var availability_datetime:String?
    var bid_price:Double?
    var availabledrop_datetime:String?
    var additionalservice_name:String?
    var additionalservice_amount:Double?
    
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
        case upfront_payment = "upfront_payment"
        case availability_datetime = "availability_datetime"
        case bid_price = "bid_price"
        case availabledrop_datetime = "availabledrop_datetime"
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
        self.upfront_payment = try container.decodeIfPresent(Double.self, forKey: .upfront_payment)
        self.availability_datetime = try container.decodeIfPresent(String.self, forKey: .availability_datetime)
        self.bid_price = try container.decodeIfPresent(Double.self, forKey: .bid_price)
        self.availabledrop_datetime = try container.decodeIfPresent(String.self, forKey: .availabledrop_datetime)
        self.additionalservice_name = try container.decodeIfPresent(String.self, forKey: .additionalservice_name)
        self.additionalservice_amount = try container.decodeIfPresent(Double.self, forKey: .additionalservice_amount)
    }
    

}


// driver pending details model

/*
 {
     "status": "True",
     "msg": "Booking Data Details",
     "data": {
         "id": 281,
         "booking_number": "PASCO160110240614043435811",
         "user": "Sandeep Sharma",
 
         "driver": "Shireen",
         "user_image": "/media/media/Screenshot_2024-05-22-17-45-48-072_com.pasco.pascocustomer_i3Ql38W.jpg",
         "driver_image": "/media/media/imageName_x01SHBc.jpeg",
 
         "shipmentname": "Light Transport Delivery",
         "vehiclename": "Pickup Truck",
         "pickup_location": "6, Mahakali Caves Rd, Shanti Nagar, Andheri East, Mumbai, Maharashtra 400053, India",
        
        "pickup_latitude": 19.11778,
         "pickup_longitude": 72.86305,
       "drop_location": "4VP5+526, Squatters Colony Rd, Janta Nagar, Bandra Plot, Harijan Nagar Nagar, Jogeshwari
                        East, Mumbai, Maharashtra 400060, India",
         "drop_latitude": 19.13542,
         "drop_longitude": 72.8575,
 
         "total_distance": 2.046304,
         "duration": 184,
      "customer_status": "pending",
 
         "payment_status": "unpaid",
         "booking_status": "pending",
         "pickup_datetime": "2024-06-29T10:03:00Z",
 
         "created_at": "2024-06-14T04:34:35.829101Z",
         "basicprice": 222.55,
         "message": "cccvv",
 
         "payment_method": "Cash",
         "upfront_payment": 50.0,
         "availability_datetime": "2024-06-30T11:06:00Z",
 
         "bid_price": 500.0,
         "commission_price": 20.23,
         "availabledrop_datetime": "2024-06-30T11:09:04Z",
 
         "additionalservice_name": null,
         "additionalservice_amount": null
     }
 }
 */
struct DriverPendingBidDetailsModel:Codable{
    var status:String?
    var msg:String?
    var data:DriverPendingBidDetailsModel_data?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decode(DriverPendingBidDetailsModel_data.self, forKey: .data)
    }
    
}

struct DriverPendingBidDetailsModel_data:Codable{
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
    
    var customer_status:String?
    var payment_status:String?
    var booking_status:String?
    
    var pickup_datetime:String?
    var created_at:String?
    var basicprice:Double?
   
    var message:String?
    var payment_method:String?
    var upfront_payment:Double?
    
    var availability_datetime:String?
    var bid_price:Double?
    var commision_price:Double?
    
    var availabledrop_datetime:String?
    var additionalservice_name:String?
    var additionalservice_amount:Double?
    
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
        case upfront_payment = "upfront_payment"
        case availability_datetime = "availability_datetime"
        case bid_price = "bid_price"
        case availabledrop_datetime = "availabledrop_datetime"
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
        self.upfront_payment = try container.decodeIfPresent(Double.self, forKey: .upfront_payment)
        self.availability_datetime = try container.decodeIfPresent(String.self, forKey: .availability_datetime)
        self.bid_price = try container.decodeIfPresent(Double.self, forKey: .bid_price)
        self.availabledrop_datetime = try container.decodeIfPresent(String.self, forKey: .availabledrop_datetime)
        self.additionalservice_name = try container.decodeIfPresent(String.self, forKey: .additionalservice_name)
        self.additionalservice_amount = try container.decodeIfPresent(Double.self, forKey: .additionalservice_amount)
    }
    

}


//driver status list model
/*
 {
     "status": "True",
     "msg": "Driver Status List ",
     "data": [
         {
             "id": 1,
             "status": "On the way"
         },
         {
             "id": 2,
             "status": "Late due to Tyre Broken"
         },
         {
             "id": 3,
             "status": "Way to Destination "
         },
         {
             "id": 4,
             "status": "I am on the way"
         }
     ]
 }
 */

struct DriverStatusListModel:Codable{
    var status:String?
    var msg:String?
    var data:[DriverStatusListModel_data]?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decode([DriverStatusListModel_data].self, forKey: .data)
    }
    
}
struct DriverStatusListModel_data:Codable{
    var status:String?
    var id:Int?
   
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case id = "id"
       
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
       
    }
    
}

//driver confirm bid details
/*
 {
     "status": "True",
     "msg": "Booking Request Status",
     "data": {
         "id": 330,
         "booking_number": "PASCO160123240615053353105",
         "user": "Sandeep Sharma",
         "driver": "Shireen",
         "user_image": "/media/media/Screenshot_2024-05-22-17-45-48-072_com.pasco.pascocustomer_i3Ql38W.jpg",
         "driver_image": "/media/media/imageName_x01SHBc.jpeg",
         "shipmentname": "Light Transport Delivery",
         "vehiclename": "Pickup Truck",
         "pickup_location": "4VP5+526, Squatters Colony Rd, Janta Nagar, Bandra Plot, Harijan Nagar Nagar, Jogeshwari East, Mumbai, Maharashtra 400060, India",
         "pickup_latitude": 19.13542,
         "pickup_longitude": 72.8575,
         "drop_location": "6, Mahakali Caves Rd, Shanti Nagar, Andheri East, Mumbai, Maharashtra 400053, India",
         "drop_latitude": 19.11778,
         "drop_longitude": 72.86305,
         "total_distance": 2.046304,
         "duration": 184,
 
         "basicprice": 222.55,
         "commision_price": 20.23,
         "message": "ccc",
         "payment_method": "Cash",
         "customer_status": "confirmed",
         "driver_status": null,
         "booking_status": "confirmed",
         "payment_status": "unpaid",
         "pickup_datetime": "2024-06-29T11:03:00Z",
         "created_at": "2024-06-15T05:33:53.107583Z",
         "availability_datetime": "2024-06-27T11:04:00Z",
         "bid_price": 300.0,
         "additionalservice_name": null,
         "additionalservice_amount": null
     }
 }
 */
struct DriverConfirmBidDetailsModel:Codable{
    var status:String?
    var msg:String?
    var data:DriverConfirmBidDetailsModel_data?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decode(DriverConfirmBidDetailsModel_data.self, forKey: .data)
    }
    
}

struct DriverConfirmBidDetailsModel_data:Codable{
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
    
    var customer_status:String?
    var driver_status:String?
    var payment_status:String?
    var booking_status:String?
    
    var pickup_datetime:String?
    var created_at:String?
    var basicprice:Double?
   
    var message:String?
    var payment_method:String?
    var upfront_payment:Double?
    
    var availability_datetime:String?
    var bid_price:Double?
    var commision_price:Double?
    
    
    var additionalservice_name:String?
    var additionalservice_amount:Double?
    
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
        case driver_status = "driver_status"
        case payment_status = "payment_status"
        case booking_status = "booking_status"
        case pickup_datetime = "pickup_datetime"
        case created_at = "created_at"
        case basicprice = "basicprice"
        case commision_price = "commision_price"
        case message = "message"
        case payment_method = "payment_method"
        case upfront_payment = "upfront_payment"
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
        self.driver_status = try container.decodeIfPresent(String.self, forKey: .driver_status)
        self.payment_status = try container.decodeIfPresent(String.self, forKey: .payment_status)
        self.booking_status = try container.decodeIfPresent(String.self, forKey: .booking_status)
        self.pickup_datetime = try container.decodeIfPresent(String.self, forKey: .pickup_datetime)
        self.created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        self.basicprice = try container.decodeIfPresent(Double.self, forKey: .basicprice)
        self.commision_price = try container.decodeIfPresent(Double.self, forKey: .commision_price)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.payment_method = try container.decodeIfPresent(String.self, forKey: .payment_method)
        self.upfront_payment = try container.decodeIfPresent(Double.self, forKey: .upfront_payment)
        self.availability_datetime = try container.decodeIfPresent(String.self, forKey: .availability_datetime)
        self.bid_price = try container.decodeIfPresent(Double.self, forKey: .bid_price)
        
        self.additionalservice_name = try container.decodeIfPresent(String.self, forKey: .additionalservice_name)
        self.additionalservice_amount = try container.decodeIfPresent(Double.self, forKey: .additionalservice_amount)
    }
    

}


//driver ongoing list model
/*
 {
     "status": "True",
     "msg": "My Bookings Record Lists",
     "data": [
         {
             "id": 279,
             "booking_number": "PASCO160109240613112932486",
             "user": "Sandeep Sharma",
 
             "user_image": "/media/media/Screenshot_2024-05-22-17-45-48-072_com.pasco.pascocustomer_i3Ql38W.jpg",
             "driver": "Abhishek",
             "driver_image": null,
 
             "shipmentname": "Light Transport Delivery",
             "vehiclename": "Pickup Truck",
             "pickup_location": "Block B, B35, B Block, Sector 59, Noida, Uttar Pradesh 201301, India",
 
             "pickup_latitude": 28.60788,
             "pickup_longitude": 77.36492,
             "drop_location": "Block B, Sector 132, Noida, Uttar Pradesh, India",
 
             "drop_latitude": 28.51108,
             "drop_longitude": 77.37981,
             "total_distance": 10.861462,
 
             "duration": 978,
             "basicprice": 707.38,
             "booking_status": "processing",
 
             "payment_status": "unpaid",
             "pickup_datetime": "2024-06-14T16:59:00Z",
             "commision_price": 64.31,
 
             "message": "fgg",
             "payment_method": "Cash",
             "customer_status": "confirmed",
 
             "additionalservice_name": null,
             "additionalservice_amount": null,
             "created_at": "2024-06-13T11:29:32.490384Z",
 
             "availability_datetime": "2024-06-15T17:00:00Z",
             "bid_price": 800.0
         }
     ]
 }
 */

struct DriverOngoingListModel:Codable{
    var status:String?
    var msg:String?
    var data:[DriverOngoingListModel_data]?
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.msg = try container.decodeIfPresent(String.self, forKey: .msg)
        self.data = try container.decode([DriverOngoingListModel_data].self, forKey: .data)
    }
    
}

struct DriverOngoingListModel_data:Codable{
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
    
    var customer_status:String?//
  
    var payment_status:String?//
    var booking_status:String?//
    
    var pickup_datetime:String?//
    var created_at:String?//
    var basicprice:Double?//
   
    var message:String?//
    var payment_method:String?//
   
    
    var availability_datetime:String?//
    var bid_price:Double?//
    var commision_price:Double?//
    
    
    var additionalservice_name:String?//
    var additionalservice_amount:Double?//
    
    var driver_status:String?
    var driver_status_id:Int?
    
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
    
        case driver_status = "driver_status"
        case driver_status_id = "driver_status_id"
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
        self.additionalservice_amount = try container.decodeIfPresent(Double.self, forKey: .additionalservice_amount)
        
        self.driver_status = try container.decodeIfPresent(String.self, forKey: .driver_status)
        self.driver_status_id = try container.decodeIfPresent(Int.self, forKey: .driver_status_id)
    }
    

}


