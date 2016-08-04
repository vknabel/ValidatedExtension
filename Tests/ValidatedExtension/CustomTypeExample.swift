//
//  CustomTypeExample.swift
//  Validated
//
//  Created by Benji Encz on 2/24/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

import ValidatedExtension

// Example of a validator that validates a custom type.

struct User {
    let username: String
    let loggedIn: Bool
}

struct LoggedInValidator: Validator {
    #if swift(>=3.0)
    static func validate(_ value: User) throws -> Bool {
        return value.loggedIn
    }
    #else
    static func validate(value: User) throws -> Bool {
        return value.loggedIn
    }
    #endif
}
