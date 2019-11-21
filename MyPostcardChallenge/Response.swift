//
//  Response.swift
//  MyPostcardChallenge
//
//  Created by user on 11/19/19.
//  Copyright © 2019 mypostcard. All rights reserved.
//

import Foundation


final class Response: Codable {
    var success: Bool
    var jwt: String
    var uid: String
    var name: String
    var lastname: String
    var email: String
    var balance: String
    var currencyiso: String
    var newsletter: Bool
    var optIn: Bool
    var friendcode: String
    var friendcode_revenue: String
    var registerdate: String
    var userAddressbookLink: String
    var birthday_reminder: Int
    
    
}
