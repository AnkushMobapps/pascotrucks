//
//  Constant.swift
//  FoodApp
//
//  Created by Apple on 8/4/23.
//

import Foundation

var base_Url = "http://69.49.235.253:8090/api/"
var image_Url = "http://69.49.235.253:8090"
//for driver
var driver_register_Url = base_Url+"user-registration/"
var driver_chek_login = base_Url+"check-login/"
var driver_update_deviceId_Url = base_Url+"update-phoneverify/"
var driver_login_Url = base_Url+"user-login/"
var driver_complete_registration_Url = base_Url+"user-registration/"
var getDriverProfileData_Url = base_Url+"user-update-profile/"
var updateddriverProfiledata_Url = base_Url+"user-update-profile/"

var countryListUrl = base_Url+"countrydetail/"
var cityListUrl = base_Url + "citydetail/"
var transporterUrl = base_Url + "service-lists/"
var vehicleListUrl = base_Url + "cargo-lists/"
var driverShowNotificationUrl = base_Url + "ShowNotification/"
var driverCountNotificationUrl = base_Url + "UnreadNotification/"
var driverDeletePertNotifiUrl = base_Url + "NotificationDelete/"
var driverClearAllNotifiUrl = base_Url + "ClearAllNotification/"
var addVehicleDetails_Url = base_Url+"approvalrequest/"
var getapproval_Url = base_Url+"updateapprovalstatus/"
var updatehicleDetails_Url = base_Url+"updateapprovalstatus/"
var selectCity_url = base_Url+"addcity/"
var onOffDuty_url = base_Url+"marked-duty-status/"
var updateBidingDetails_url = base_Url+"updatebookingbid/"
var confirmOrder_url = base_Url+"updatebookingbid/"
var driver_logout_url = base_Url+"user-logout/"
var driverUpdateLocation_url = base_Url+"location-update/"
var driverAddNote_url = base_Url+"add-reminder/"
var driverGetNote_url = base_Url+"add-reminder/"
var driverBidingstatus_url = base_Url+"bookingdriverbiddetail/"
var driverPendingBidDetails_url = base_Url+"bookingdriverdata/"
var driverConfirmBidDetails_url = base_Url+"afterstarttrip/"
var driverStatusList_url = base_Url+"driver_status_list/"
var driverOngoingBidList_url = base_Url+"bookdriver-ongoing/"
var drivercompleteOrder_url = base_Url+"bookclient-completed/"
var drivercancelOrder_url = base_Url+"bookclient-cancelled/"



// MARK: Client Side Api

 let cleintRegister_Url = base_Url+"client-registration/"
let chekRegNum_Url = base_Url+"check-number/"
let clientUpdateProfile_Url = base_Url+"user-update-profile/"
let getProfile_Url = base_Url+"user-update-profile/"
let clientLogout_Url = base_Url+"user-logout/"
let vehicleType_Url = base_Url+"cargo-lists/"
let addtionalService_Url = base_Url+"additional-service/"
let paymentMethod_url =  base_Url+"ride-booking/"
let cargoQty_Url = base_Url+"checkavailability/"
let chekCharges_Url = base_Url+"checkcharges/"
let homePegeingApi = base_Url+"slideshow-detail/"
let orderRequestApi = base_Url+"request-send/"
let allBids_Url = base_Url+"afterbidlist/"
let acceptOrder_Url = base_Url+"acceptedbooking/"





//MARK: - Validation Alert Message

struct Constant {
    static let PROGRESS_TITLE = "Loading..."
    static let PasswordValidation = "Password must be minimum 8 characters, at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character."
    static let PdfBlank = "Please Select Address Documents"
    static let LoginSafeValidation = "Please select identification."
    static let RejectAlert = "Please enter your reject reason"
    static let reasonText = "Please enter your  reason"
    static let CancelReservation = "Please enter cancel reservation reason"

    static let MESSAGE_NETWORK = "Please check network connection"
//    static let STATETEXTFIELD = "Please Enter State"
    //Pasco project
    static let TITLE = "Pasco"
    static let CityTEXTFIELD = "Please enter citiy name"
    static let CountryCode = "Please enter your country code"
    static let phoneNumber = "Please enter your phone number"
    static let VehicleImg = "Please select vehicle image"
    static let drivinglicenseImg = "Please select driving license image"
    static let drivingRCImg = "Please select RC image"
    static let vehicleNumberTxt = "Please enter the vehicle number"
    static let emailNotValid = "Please enter correct email"
    static let emptyEmailTxt = "please enter your email"
    static let emptyNameTxt = "Please enter your name"
    static let emptyImage = "Please select any image"
    static let shipmentTypeTxt = "Please select shipment type"
    static let vehicleTypeTxt = "Please select vehicle type"
    
    
    
    
    
    
    
    
    
    
    static let availableSeat = "You have selected Date  is not available, please select another date. "
    static let BLANK = ""
    static let SPACE = " "
    static let ZERO = 0
    static let SUCCESS = "True"
    static let MSG_LOGOUT = "Are you sure you want to logout."
    static let FirstName = "Enter the first name."
    static let LastName = "Enter the last name."
    static let Address = "Enter the address."
    static let countryCode = "Please Select Country Code"
    static let MobileNumber = "Enter the mobile number."
    static let Mobile_VAlidation = "Enter valid mobile number."
    static let Email = "Enter the email."
    static let Email_Validation = "Email address is not valid."
    static let password = "Enter the password."
    static let ConfirmPassword = "Enter the confirm password."
    static let PasswordMatch = "Please enter same password"
    static let hostName = "Enter the hostName"
    static let tradeliecence = "Please upload tradeliecence"
    static let Aboutme = "Enter the Aboutme"
    static let WalletMsg = "Please enter amount"
    static let CuisineStyle = "Please Select Cuisine style"
    static let feesPerPerson = "Please enter  fees per person"
    static let feesPerGroup = "Please enter  fees per group"
    static let bankCountry = "Please Enter Bank Country"
    static let bankName = "Please Enter Bank Name"
    static let bankIban = "Please Enter Bank IBAN"
    static let BankSwiftCode = "Please Enter Bank Swift Code"
    static let AccountCurrency = "Please Enter Account Currency"
    static let ForgetPassword = "Please enter email id"
    static let OTPValidation  = "Please enter 4 digit OTP"
    static let RatingMsg = "Please select rating"
    static let FeedbackMsg = "Please enter feedback message"
    static let FeedbackType = "Please select feedback Type"
    static let CardNumber  = "Please Enter Card Number"
    static let CardHolderName = "Please Enter Card Holder Name"
    static let CardExpirey = "Please Enter Expirey Date"
    static let CardCVV = "Please Enter CVV"
    static let FoodDescription = "Please Enter Food Description"
    static let pendingAccount = "Your account is not verified yet it is pending."
    static let rejectAccount = "Your account has been rejected by admin"
    static let adultAdd = "Please add adult"
    static let deactivateProfile = "Please confirm to deactivate your profile."
    static let signOut = "Do you want to sign Out ?"
    static let paymentMethod = "Please Select Payment Method"
    static let paymentInvalid = "Please Enter Valid Details"
    static let hostingArea = "Please Select Hosting Area"
    static let walletBalance = "Your wallet account does not have sufficient balance. Please add balance to your wallet."
    static let activitiesMsg = "Please Select Activities"
    static let selectDate = "Please select Date"
    static let transaction_failed = "Your transaction failed. Please try again."
    static let hostDeleteMsg = "Are you sure you want to delete this host? All Data saved will be erased"
    
    
    

    
    
    
    
    static let LOGOUT = "Logout"
    static let CURRENCY = "FCFA"
    static let EMAIL_ENTER = "Please enter email."
    static let EMAIL_VALIDATION = "Please enter valid email."
    static let FRIST_NAME = "Please enter frist name."
    static let LAST_NAME = "Please enter last name."
    static let ENTER_DOB = "Please enter Date of Birth."
    static let ENTER_ADDRESS = "Please enter address."
    static let SELECT_GENDER = "Please select gender."
    static let ENTER_PHONE_NUMBER = "Please enter phone number."
    static let PHONE_NUMBER_VALIDATION = "Please enter valid phone number must have in between 7 to 15 number."
    static let PASSWORD_VALIDATION = "Please enter valid Password must have in between 8 to 15 characters , Password contain 1 special character , 1 digit , 1 uppercase letter. 1 lowwercase letter."
    static let SELECT_COUNTRY = "Please Select your country"
    static let SELECT_COUNTRYCODE = "Please Select your country Code"
    static let PASSWORD_NOT_MATCH = "New password doesn't match with confirm password."
    static let ENTER_OLD_PASSWORD = "Please enter old password."
    static let ENTER_NEW_PASSWORD = "Please enter new password."
    static let ENTER_CONFIRM_PASSWORD = "Please enter confirm password."
    static let VALID_EMAIL = "The email must be a valid email address."
    static let ASK_LOGIN = "Please Frist Login To Access your Profile"
    static let PLS_LOGIN = "Please Login"
    static let About = "The about must be at least 50 characters"
    static let INSTAGRAM_LINK = "Please fill instagramLink section!"
    static let Image_Url  = "Please Upload Image!"
    static let All_FIELD  = "Please Fill all the field"
}

