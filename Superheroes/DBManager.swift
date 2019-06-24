//
//  DBManager.swift
//  Superheroes
//
//  Created by Elmer Astudillo on 6/22/19.
//  Copyright © 2019 Elmer Astudillo. All rights reserved.
//

import UIKit
import RealmSwift
class DBManager {
    private var database:Realm
    static let sharedInstance = DBManager()
    private init() {
        database = try! Realm()
    }
    
    func getDataFromDB() -> Results<SuperheroRealm> {
        let results: Results<SuperheroRealm> = database.objects(SuperheroRealm.self)
        return results
    }
    
    func addData(superheroRealm: SuperheroRealm, powerstatsRealm: PowerstatsRealm, biographyRealm: BiographyRealm)   {
        try! database.write {
            database.add(biographyRealm, update: true)
            database.add(powerstatsRealm, update: true)
            database.add(superheroRealm, update: true)
        }
    }
    
    func deleteAllFromDatabase()  {
        try! database.write {
            database.deleteAll()
        }
    }
    
    func deleteFromDb(superheroRealm: SuperheroRealm, powerstatsRealm: PowerstatsRealm, biographyRealm: BiographyRealm)   {
        try! database.write {
            database.delete(superheroRealm)
            database.delete(powerstatsRealm)
            database.delete(biographyRealm)
        }
    }
}
