//
//  User.swift
//  Peoplemon
//
//  Created by Caden Cheek on 11/7/16.
//  Copyright © 2016 Interapt. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

class User:NetworkModel {

    var id: String?
    var username: String?
    var email : String?
    var hasRegistered: Bool?
    var loginProvider: String?
    var fullName: String?
    var avatarBase64: String?
    var lastCheckInLongitude: Double?
    var lastCheckInLatitude: Double?
    var lastCheckInDateTime: String?
    var authorization: String?
    var oldPassword: String?
    var newPassword: String?
    var confirmPassword: String?
    var apiKey: String?
    var password: String?
    var token: String?
    var expiration : String?
    var grantType: String? = "password"


    // Request Type
    enum RequestType {
        case login
        case updateUserInfo
        case changePassword
        case setPassword
        case register
        case getUserInfo

    }
    var requestType = RequestType.register


    // empty constructor
    required init() {}

    // create an object from JSON
    required init(json: JSON) throws {
        token = try? json.getString(at: Constants.People.token)
        expiration = try? json.getString(at: Constants.People.expirationDate)
        id = try? json.getString(at: Constants.People.id)
        email = try? json.getString(at: Constants.People.email)
        hasRegistered = try? json.getBool(at: Constants.People.hasRegistered)
        loginProvider = try? json.getString(at: Constants.People.loginProvider)
        fullName = try? json.getString(at: Constants.People.fullname)
        avatarBase64 = try? json.getString(at: Constants.People.avatarBase64)
        lastCheckInLongitude = try? json.getDouble(at: Constants.People.lastCheckInLongitude)
        lastCheckInLatitude = try? json.getDouble(at: Constants.People.lastCheckInLatitude)
        lastCheckInDateTime = try? json.getString(at: Constants.People.lastCheckInDateTime)
        authorization = try? json.getString(at: Constants.People.authorization)
        oldPassword = try? json.getString(at: Constants.People.oldPassword)
        newPassword = try? json.getString(at: Constants.People.newPassword)
        confirmPassword = try? json.getString(at: Constants.People.confirmPassword)
        apiKey = try? json.getString(at: Constants.People.apiKey)

        grantType = try? json.getString(at: Constants.People.grantType)
        username = try? json.getString(at: Constants.People.email)
        password = try? json.getString(at: Constants.People.token)

    }
    //parameters email and password
    init( userName: String, password: String) {
       // self.grantType = grantType
        self.username = userName
        self.password = password

        requestType = .login
    }
    init(fullName: String, avatarBase64: String) {
        self.fullName = fullName
        self.avatarBase64 = avatarBase64
        requestType = .updateUserInfo
    }
    init(oldPassword: String, newPassword: String, confirmPassword: String) {
        self.oldPassword = oldPassword
        self.newPassword = newPassword
        self.confirmPassword = confirmPassword
        requestType = .changePassword
    }
    init(newPassword: String) {
        self.newPassword = newPassword
        requestType = .setPassword
    }

    init(fullName: String, password: String, email: String, avatarBase64: String, apiKey: String) {
        self.email = email
        self.password = password
        self.fullName = fullName
        self.avatarBase64 = avatarBase64
        self.apiKey = Constants.apiKey
        requestType = .register
    }
    init(userName: String, email: String, hasRegistered: Bool, loginProvider: String, fullName: String, avatarBase64: String, lastCheckInLongitude: Double, lastCheckInLatitude: Double, lastCheckInDateTime: String) {
        self.username = userName
        self.email = email
        self.hasRegistered = hasRegistered
        self.loginProvider = loginProvider
        self.fullName = fullName
        self.avatarBase64 = avatarBase64
        self.lastCheckInLongitude = lastCheckInLongitude
        self.lastCheckInLatitude = lastCheckInLatitude
        self.lastCheckInDateTime = lastCheckInDateTime
        requestType = .getUserInfo
    }



    //init(id: String) {
    // self.userName = id
    //}

    // Always return HTTP.GET
    //determines the HTTP method we will use in our calls. Can use conditionals to determine this based on the endpoint we are calling or what we decide we would like to do
    func method() -> Alamofire.HTTPMethod {
        switch requestType{
        case .getUserInfo:
            return .get
        default:
            return .post
        }
    }
    //determines the path we will append to the API base URL //we switch this endpoint based on what type of request we would like to make
    // A sample path to a single post
    func path() -> String {
        switch requestType {
        case .updateUserInfo:
            return "/api/Account/UserInfo"
        case .changePassword:
            return "/api/Account/ChangePassword"
        case .setPassword:
            return "/api/Account/SetPassword"
        case .login:
            return "/token"
        case .register:
            return "/api/Account/Register"
        case .getUserInfo:
            return "/api/Account/UserInfo"

        }
    }

    // Demo object isn't being posted to a server, so just return nil   //switch//register parameters
    func toDictionary() -> [String: AnyObject]? {
        var params: [String: AnyObject] = [:]
        switch requestType {
        case .register:
            params[Constants.People.fullname] = fullName as AnyObject?
            params[Constants.People.email] = email as AnyObject?
            params[Constants.People.password] = password as AnyObject?
            params[Constants.People.avatarBase64] = avatarBase64 as AnyObject?
            params[Constants.People.apiKey] = apiKey as AnyObject?

        case .login:///login parameters with granttype username and password make username = email
            params[Constants.People.grantType] = grantType as AnyObject?
            params[Constants.People.username] = username as AnyObject?
            params[Constants.People.password] = password as AnyObject?
            print(params)

        case .updateUserInfo:
            params[Constants.People.fullname] = fullName as AnyObject?
            params[Constants.People.avatarBase64] = avatarBase64 as AnyObject?

        default:
            break
        }
        print(params)
        return params
    }
    
}
