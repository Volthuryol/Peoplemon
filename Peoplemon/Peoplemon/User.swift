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

class User: NetworkModel {
    var id : Int?
    var username: String?
    var password: String?
    var email: String?
    var token: String?
    var expiration: String?

    enum RequestType {
        case login
        case register
    }
    var requestType = RequestType.login

    //empry contstructor
    required init() {}

    //create an object from JSON
    required init(json: JSON) throws {
        token = try? json.getString(at: Constants.BudgetUser.token)
        expiration = try? json.getString(at: Constants.BudgetUser.expirationDate)
    }

    init(username: String, password: String) {
        self.username = username
        self.password = password
        requestType = .login
    }

    init(username: String, password: String, email: String) {
        self.username = username
        self.password = password
        self.email = email
        requestType = .register
    }

    init(id: Int) {
        self.id = id
    }

    //Always return HTTP.GET // there is a get for every post in a api
    func method() -> Alamofire.HTTPMethod {
        return .post
    }

    //S sample path to a single post
    func path() -> String {
        switch requestType {
        case .login:
            return "/auth"
        case .register:
            return "/register"

        }
    }

    //Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String : AnyObject]? {
        var params: [String: AnyObject] = [:]
        params[Constants.BudgetUser.username] = username as AnyObject?
        params[Constants.BudgetUser.password] = password as AnyObject?

        switch requestType {
        case .register:
            params[Constants.BudgetUser.email] = email as AnyObject?
        default:
            return nil
        }
        return params
    }
}
