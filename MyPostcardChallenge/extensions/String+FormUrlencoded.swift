//
//  StringExtension.swift
//  MyPostcardChallenge
//
//  Created by user on 11/20/19.
//  Copyright © 2019 mypostcard. All rights reserved.
//

import Foundation


extension String {
    static let formUrlencodedAllowedCharacters =
        CharacterSet(charactersIn: "0123456789" +
            "abcdefghijklmnopqrstuvwxyz" +
            "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
            "-._* ")

    public func formUrlencoded() -> String {
        let encoded = addingPercentEncoding(withAllowedCharacters: String.formUrlencodedAllowedCharacters)
        return encoded?.replacingOccurrences(of: " ", with: "+") ?? ""
    }
}
