//
//  GenericReponse.swift
//  MyPostcardChallenge
//
//  Created by user on 11/21/19.
//  Copyright © 2019 mypostcard. All rights reserved.
//

import Foundation

final class HTTPGenericResponse: Codable {
    var success: Bool
    var message: String
    var data: Data
    
    init(success: Bool, message: String, data: Data){
        self.success = success
        self.message = message
        self.data = data
    }
    
}
