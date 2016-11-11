//
//  Account.swift
//  Peoplemon
//
//  Created by Caden Cheek on 11/7/16.
//  Copyright © 2016 Interapt. All rights reserved.
//

import Foundation
import Alamofire
import Freddy
import MapKit

class People: NetworkModel {
    var userId: String?
    var userName: String?
    var avatarBase64: String?
    var latitude: Double?
    var longitude: Double?
    var created: String?
    var radius: Double?
    var caughtUserId: String?
    var conversationId: String?
    var recipientId: String?
    var recipientName: String?
    var lastMessage: String?
    var messageCount: Int?
    var senderId: String?
    var senderName: String?
    var recipientAvatarBase64: String?
    var senderAvatarBase64: String?
    var grant_type: String?
    var expiration: Int?




    enum RequestType {
        case nearby
        case checkIn
        case catchPerson
        case caught
        case conversations
        case register
        case login

    }
    var requestType: RequestType = .nearby

    required init() {}

    // create an object from JSON
    required init(json: JSON) throws {
        userId = try? json.getString(at: Constants.People.userId)
        userName = try? json.getString(at: Constants.People.username)
        avatarBase64 = try? json.getString(at: Constants.People.avatarBase64)
        latitude = try? json.getDouble(at: Constants.People.latitude)
        longitude = try? json.getDouble(at: Constants.People.longitude)
        created = try? json.getString(at: Constants.People.created)
        radius = try? json.getDouble(at: Constants.People.radius)
        caughtUserId = try? json.getString(at: Constants.People.caughtUserId)
        conversationId = try? json.getString(at: Constants.People.conversationId)
        recipientId = try? json.getString(at: Constants.People.recipientId)
        recipientName = try? json.getString(at: Constants.People.recipientName)
        lastMessage = try? json.getString(at: Constants.People.lastMessage)

        messageCount = try? json.getInt(at: Constants.People.messageCount)
        senderId = try? json.getString(at: Constants.People.senderId)
        senderName = try? json.getString(at: Constants.People.senderName)
        recipientAvatarBase64 = try? json.getString(at: Constants.People.recipientAvatarBase64)
        senderAvatarBase64 = try? json.getString(at: Constants.People.senderAvatarBase64)
        grant_type = try? json.getString(at: Constants.People.grantType)
        expiration = try? json.getInt(at: Constants.People.expirationDate)

    }

    init(radius: Double) {
        self.radius = radius
        self.requestType = .nearby
    }

    init(coordinate: CLLocationCoordinate2D) {
        self.longitude = coordinate.longitude
        self.latitude = coordinate.latitude
        requestType = .checkIn
    }

    init(userId: String, radius: Double) {
        self.userId = userId
        self.radius = radius
        requestType = .catchPerson
    }
    init(userId: String, avatarBase64: String, created: String, userName: String) {
        self.userId = userId
        self.userName = userName
        self.created = created
        self.avatarBase64 = avatarBase64
        requestType = .caught
    }

    init(conversationId: Int, recipientId: String, recipientName: String, lastMessage: String, created: String, messageCount: Int, avatarBase64: String, senderId: String, senderName: String, recipientAvatarBase64: String, senderAvatarBase64: String) {
        self.conversationId = "0"
        self.recipientId = recipientId
        self.recipientName = recipientName
        self.lastMessage = lastMessage
        self.created = created
        self.messageCount = messageCount
        self.avatarBase64 = avatarBase64
        self.senderId = senderId
        self.senderName = senderName
        self.recipientAvatarBase64 = recipientAvatarBase64
        self.senderAvatarBase64 = senderAvatarBase64
        requestType = .conversations

    }

    // Always return HTTP.GET
    func method() -> Alamofire.HTTPMethod {
        switch requestType {
        case .nearby, .caught:
            return .get
        default:
            return .post
        }
    }
    // A sample path to a single post
    func path() -> String {
        switch requestType {
        case .nearby:
            return "/v1/User/Nearby"
        case .checkIn:
            return "/v1/User/CheckIn"
        case .catchPerson:
            return "/v1/User/Catch"
        case .caught:
            return "/v1/User/Caught"
        case .conversations:
            return "/v1/User/Conversations"
            //case .conversation:
        //return "/v1/User/Conversation"
        case .login:
            return "/token"
        case .register:
            return "/api/Account/Register"

        }
    }
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        var params: [String: AnyObject] = [:]
        switch requestType {
        case .checkIn:
            //let startDate = Utils.adjustedTime().toString(.iso8601(nil))


            params[Constants.People.latitude] = latitude as AnyObject?
            params[Constants.People.longitude] = longitude as AnyObject?


        case .catchPerson:
            //needs work

           //params[Constants.People.username] = userName as AnyObject?
            //params[Constants.People.latitude] = latitude as AnyObject?
            //params[Constants.People.longitude] = longitude as AnyObject?

            params[Constants.People.caughtUserId] = userId as AnyObject?
            params[Constants.People.radius] = radius as AnyObject?

        case .nearby:
            params[Constants.People.radius] = radius as AnyObject?


        default:
            return nil
        }
        return params
    }
    
    
    
}




