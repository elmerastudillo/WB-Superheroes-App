//
//  SuperheroRealm.swift
//  Superheroes
//
//  Created by Elmer Astudillo on 6/22/19.
//  Copyright © 2019 Elmer Astudillo. All rights reserved.
//

import Foundation
import RealmSwift

class SuperheroRealm: Object {
    @objc dynamic var id = ""
    @objc dynamic var imageURL = ""
    @objc dynamic var name = ""
    @objc dynamic var biography: BiographyRealm?
    @objc dynamic var powerstats: PowerstatsRealm?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
