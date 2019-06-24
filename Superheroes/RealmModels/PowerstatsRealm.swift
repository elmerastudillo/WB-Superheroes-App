//
//  PowerstatsRealm.swift
//  Superheroes
//
//  Created by Elmer Astudillo on 6/22/19.
//  Copyright © 2019 Elmer Astudillo. All rights reserved.
//

import Foundation
import RealmSwift

class PowerstatsRealm : Object {
    @objc dynamic var id = ""
    @objc dynamic var combat = ""
    @objc dynamic var durability = ""
    @objc dynamic var intelligence = ""
    @objc dynamic var power = ""
    @objc dynamic var strength = ""
    @objc dynamic var speed = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
