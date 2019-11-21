//
//  HTTPUtils.swift
//  MyPostcardChallenge
//
//  Created by user on 11/20/19.
//  Copyright © 2019 mypostcard. All rights reserved.
//

import Foundation


class HTTPUtils {
    public class func formUrlencode(_ values: [String: String]) -> String {
        return values.map { key, value in
            return "\(key.formUrlencoded())=\(value.formUrlencoded())"
        }.joined(separator: "&")
    }
}
