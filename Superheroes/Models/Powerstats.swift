//
//  Powerstats.swift
//  Superheroes
//
//  Created by Elmer Astudillo on 6/20/19.
//  Copyright © 2019 Elmer Astudillo. All rights reserved.
//

import Foundation

struct Powerstats {
    var combat: String
    var durability: String
    var intelligence: String
    var power: String
    var strength: String
    var speed: String
    
    init(combat: String, durability: String, intelligence: String, power:String, strength:String, speed: String) {
        self.combat = combat
        self.durability = durability
        self.intelligence = intelligence
        self.power = power
        self.strength = strength
        self.speed = speed
    }
}

