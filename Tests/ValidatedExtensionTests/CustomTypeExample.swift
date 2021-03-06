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
    static func validate(_ value: User) throws -> Bool {
        return value.loggedIn
    }
}
