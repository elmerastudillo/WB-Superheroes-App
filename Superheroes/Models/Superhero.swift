//
//  Superhero.swift
//  Superheroes
//
//  Created by Elmer Astudillo on 6/20/19.
//  Copyright © 2019 Elmer Astudillo. All rights reserved.
//

import Foundation

struct Superhero {
    var biography: Biography?
    var id: String
    var imageURL: String
    var name: String
    var powerstats: Powerstats?
    
    init(biography: Biography, id: String, imageURL: String, name: String, powerstats: Powerstats) {
        self.biography = biography
        self.id = id
        self.imageURL = imageURL
        self.name = name
        self.powerstats = powerstats
    }
}

extension Superhero: Decodable{
    enum keys: String, CodingKey{
        case id
        case image
        case name
        case powerstats
        case biography
    }
    
    enum nestedBiographyKeys: String, CodingKey{
        case alignment
        case fullName = "full-name"
        case placeOfBirth = "place-of-birth"
        case publisher
    }
    
    enum nestedImageKey: String, CodingKey{
        case url
    }
    
    enum nestedPowerstatKeys: String, CodingKey{
        case combat
        case durability
        case intelligence
        case power
        case strength
        case speed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: keys.self)
        let id = try container.decodeIfPresent(String.self, forKey: .id) ?? "None"
        let name = try container.decodeIfPresent(String.self, forKey: .name) ?? "None"
        let nestedBiographyContainer = try container.nestedContainer(keyedBy: nestedBiographyKeys.self, forKey: .biography)
        let alignment = try nestedBiographyContainer.decodeIfPresent(String.self, forKey: .alignment) ?? "None"
        let fullName = try nestedBiographyContainer.decodeIfPresent(String.self, forKey: .fullName) ?? "None"
        let placeOfBirth = try nestedBiographyContainer.decodeIfPresent(String.self, forKey: .placeOfBirth) ?? "None"
        let publisher = try nestedBiographyContainer.decodeIfPresent(String.self, forKey: .publisher) ?? "None"
        let biography = Biography(alignment: alignment.capitalizingFirstLetter(), fullName: fullName, placeOfBirth: placeOfBirth, publisher: publisher)
        let nestedImageContainer = try container.nestedContainer(keyedBy: nestedImageKey.self, forKey: .image)
        let imageURL = try nestedImageContainer.decodeIfPresent(String.self, forKey: .url) ?? "None"
        let nestedPowerstatsContainer = try container.nestedContainer(keyedBy: nestedPowerstatKeys.self, forKey: .powerstats)
        let combat = try nestedPowerstatsContainer.decodeIfPresent(String.self, forKey: .combat) ?? "None"
        let durability = try nestedPowerstatsContainer.decodeIfPresent(String.self, forKey: .durability) ?? "None"
        let intelligence = try nestedPowerstatsContainer.decodeIfPresent(String.self, forKey: .intelligence) ?? "None"
        let power = try nestedPowerstatsContainer.decodeIfPresent(String.self, forKey: .power) ?? "None"
        let strength = try nestedPowerstatsContainer.decodeIfPresent(String.self, forKey: .strength) ?? "None"
        let speed = try nestedPowerstatsContainer.decodeIfPresent(String.self, forKey: .speed) ?? "None"
        let powerstats = Powerstats(combat: combat, durability: durability, intelligence: intelligence, power: power, strength: strength, speed: speed)
        self.init(biography: biography, id: id, imageURL: imageURL, name: name, powerstats: powerstats)
    }
}

struct Superheroes: Decodable{
    let results: [Superhero]
}
