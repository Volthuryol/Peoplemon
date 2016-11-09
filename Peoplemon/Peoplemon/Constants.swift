//
//  Constants.swift
//  Peoplemon
//
//  Created by Caden Cheek on 11/7/16.
//  Copyright © 2016 Interapt. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    // Step 16: Add monthDayYear
    static let monthDayYear = "MM/dd/yyyy"

    // Step 7: Add keychain strings
    public static let keychainIdentifier = "PeoplemonKeychain"
    public static let authTokenExpireDate = "authTokenExpireDate"
    public static let authToken = "authToken"
    static let apiKey = "iOSandroid301november2016"
    static let radius = 100.0



    // JSON Constants
    struct JSON {
        static let unknownError = "An Unknown Error Has Occurred"
        static let processingError = "There was an error processing the response"
    }


    // Step 10: User Constants
    struct People {

        static let id = "Id"
        static let email = "Email"
        static let hasRegistered = "HasRegistered"
        static let loginProvider = "LoginProvider"
        static let fullname = "FullName"
        static let avatarBase64 = "AvatarBase64"
        static let lastCheckInLongitude = "LastCheckInLongitude"
        static let lastCheckInLatitude = "LastCheckInLatitude"
        static let lastCheckInDateTime = "LastCheckInDateTime"
        static let authorization = "Authorization"
        static let oldPassword = "OldPassword"
        static let newPassword = "NewPassword"
        static let confirmPassword = "ConfirmPassword"
        static let apiKey = "ApiKey"
        static let password = "password"
        static let grantType = "grant_type"
        static let username = "username"
        static let token = "access_token"
        static let expirationDate = ".expires"

        static let userId = "UserId"
        static let longitude = "Longitude"
        static let latitude = "Latitude"
        static let created = "Created"
        static let radius = "RadiusInMeters"
        static let caughtUserId = "CaughtUserId"
        static let conversationId = "ConversationId"
        static let recipientId = "RecipientId"
        static let recipientName = "RecipientName"
        static let lastMessage = "LastMessage"
        static let messageCount = "MessageCount"
        static let senderId = "SenderId"
        static let senderName = "SenderName"
        static let recipientAvatarBase64 = "RecipientAvatarBase64"
        static let senderAvatarBase64 = "SenderAvatarBase64"
    }
}

// MARK: - Colors
// Step 14: UIColor extension and
extension UIColor {
    public class func rgba(red: NSInteger, green: NSInteger, blue: NSInteger, alpha: Float = 1.0) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
    }
}
