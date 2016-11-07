//
//  WebModel.swift
//  Peoplemon
//
//  Created by Caden Cheek on 11/7/16.
//  Copyright © 2016 Interapt. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

//Describes what you need to make a network request and read ite
protocol NetworkModel: JSONDecodable {
    //create the object by readin JSON
    init(json: JSON) throws
    //create an empty object
    init()

    //what is the HTTP Method (Get/post/put/etc)
    func method() -> Alamofire.HTTPMethod
    //REST URL to the resource i.e. http://server.com/posts/1
    func path() -> String
    //Convert the object to a dictionary for later conversion to JSON
    func toDictionary() -> [String: AnyObject]?

}
