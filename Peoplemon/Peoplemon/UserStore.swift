//
//  UserStore.swift
//  Peoplemon
//
//  Created by Caden Cheek on 11/7/16.
//  Copyright © 2016 Interapt. All rights reserved.
//

import Foundation
import UIKit

protocol UserStoreDelegate: class {
    func userLoggedIn()
}

class UserStore {
    static let shared = UserStore ()
    private init() {}

    var selectedImage: UIImage?

    var user: User? {
        didSet{
            if let _ = user {
                delegate?.userLoggedIn()
            }
        }
    }
    weak var delegate: UserStoreDelegate?

    func login(_ loginUser: User, completion:@escaping
        (_ success:Bool, _ error: String?) -> ()) {

        // Call web service to login
        WebServices.shared.authUser(loginUser) { (user, error) in
            if let user = user {
                WebServices.shared.setAuthToken(user.token, expiration: user.expiration)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }

    func register(_ registerUser: User, completion:@escaping
        (_ success:Bool, _ error: String?) -> ()) {

        // Call web service to login
        WebServices.shared.authUser(registerUser) { (user, error) in
            if let user = user {
                WebServices.shared.setAuthToken(user.token, expiration: user.expiration)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }

    func logout(_ completion:() -> ()) {
        WebServices.shared.clearUserAuthToken()
        completion()
    }

}
