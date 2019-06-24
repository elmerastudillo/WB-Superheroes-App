//
//  BiographyRealm.swift
//  Superheroes
//
//  Created by Elmer Astudillo on 6/22/19.
//  Copyright © 2019 Elmer Astudillo. All rights reserved.
//

import Foundation
import RealmSwift

class BiographyRealm : Object {
    @objc dynamic var id = ""
    @objc dynamic var placeOfBirth = ""
    @objc dynamic var fullName = ""
    @objc dynamic var publisher = ""
    @objc dynamic var alignment = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
