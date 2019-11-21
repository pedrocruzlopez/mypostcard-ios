//
//  Message.swift
//  MyPostcardChallenge
//
//  Created by user on 11/20/19.
//  Copyright © 2019 mypostcard. All rights reserved.
//

import Foundation


final class Message : Codable{
    var email: String
    var password: String
    
    init(email: String, password: String){
        self.email = email
        self.password = password
    }
}
