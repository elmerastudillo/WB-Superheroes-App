//
//  Biography.swift
//  Superheroes
//
//  Created by Elmer Astudillo on 6/20/19.
//  Copyright © 2019 Elmer Astudillo. All rights reserved.
//

import Foundation

struct Biography {
    var alignment: String
    var fullName: String
    var placeOfBirth: String
    var publisher: String
    
    init(alignment: String, fullName: String, placeOfBirth: String, publisher: String) {
        self.alignment = alignment
        self.fullName = fullName
        self.placeOfBirth = placeOfBirth
        self.publisher = publisher
    }
}

