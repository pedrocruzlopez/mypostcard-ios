//
//  Session.swift
//  MyPostcardChallenge
//
//  Created by user on 11/22/19.
//  Copyright © 2019 mypostcard. All rights reserved.
//

import Foundation


class Session{
    
    static let shared = Session()
    
    
    var jwtToken: String?
    //Initializer access level change now
    private init(){}
    
    func setSessionToken(_ token: String){
        jwtToken = token
    }
    
    func getSessionToken () -> String {
        return jwtToken ?? ""
    }
    
}
