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
    public static let keychainIdentifier = "ProjectPeoplemonKeychain"
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

        static let id = "id"
        static let userId = "userId"
        static let username = "username"
        static let latitude = "latitude"
        static let longtitude = "longtitude"

        static let created = "2016-11-03T20:44:12.608Z"
        static let conversationId = "conversationId"
        static let recipientId = "recipientId"
        static let reipientName = "recipientName"
        static let lastMessage = "lastMessage"
        static let message = "message"
        static let messageCount = "messageCount"
        static let senderId = "senderId"
        static let senderName = "senderName"
        static let recipiantAvatar = "recipiantAvatar"
        static let senderAvatar = "senderAvatar"

        static let avatarBase64 = "avatarBase64"
        static let oldPassword = "oldPassword"
        static let newPassword = "newPassword"
        static let confirmPassword = "confirmPassword"
        static let hasRegistered = "hasRegistered"
        static let loginProvider = "loginProvider"
        static let avatarBase63 = "avatarBase64"
        static let lastCheckInLongitude = "0"
        static let lastCheckInLatitude = "0"
        static let lastCheckInDateTime = "0"

        static let userID = "userId"
        static let email = "email"
        static let fullname = "fullname"
        static let password = "password"
        static let changePassword = "changepassword"
        static let setPassword = "setPassword"

        static let longitude = "0"

        static let apiKey = "iOSandroid301november2016"
        static let token = "34nkCKgV1ewLfzyFQKvtI_CGVjfdjrYe2bBZWwCl7kH9SgV84-Vh3UAhBJXJNXBFxaFE5pvk__xFI41MDrY1BnATe-4ih4_XDAcSEJLXy3J-8ZGhgE2fHETNwYauGU1sdg5BchhxIoREPzQU8f7fPkAFA-mj1VoRXW8vcK0a73K3ajspmX7NuiQgzXQ_ozVYc9M8uckytVU4mnLQX0_LjuAlc9hPj4MNsZ5SdZlDytZ3nGIsLt9xPWXuVZR3_g50KI5aJVwXhgehD4NaitQOK2cSfR1y3g6NOOko-nwmVHAWBfX70p67xF6GRfn-V5UEWXAR3J5-fd5P_y5ab6SxvoNlXHhinijRZJA-pj9_5MuNRVeXbnm_XUvx_3uyGB4wVcRrcmxr117xp1Gk5erTo603S9_FVc8SxE9vTjGPMXYgbGqI_g9Gqs0bZqy4KBmdJE2OCZx73veYfXv1fw0qrTTfQLn7fbM3RJwbgcCIGEA"
        static let expiration = "expiration"
        static let grantType = "grantType"

        static let date = "date"

    }
}

// MARK: - Colors
// Step 14: UIColor extension and
extension UIColor {
    public class func rgba(red: NSInteger, green: NSInteger, blue: NSInteger, alpha: Float = 1.0) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
    }
}
