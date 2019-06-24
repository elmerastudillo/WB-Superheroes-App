//
//  String+shared.swift
//  Superheroes
//
//  Created by Elmer Astudillo on 6/23/19.
//  Copyright © 2019 Elmer Astudillo. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
