//
//  User.swift
//  FoodTracker
//
//  Created by Shahin on 2017-11-06.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
import UICKeyChainStore

class User
{
    typealias user = Constnats.Keys.Network.User
    typealias keychain = Constnats.Keys.Keychain
    
    // MARK: - Properties
    var username = ""
    var password = ""
    
    // MARK: - Helpers
    func parse(with json: [String: Any])
    {
        username = json[user.username] as! String
        password = json[user.password] as! String
        UICKeyChainStore.setString(json[user.token] as? String, forKey: keychain.token)
    }
}
