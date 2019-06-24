//
//  StoredHeroTableViewCell.swift
//  Superheroes
//
//  Created by Elmer Astudillo on 6/22/19.
//  Copyright © 2019 Elmer Astudillo. All rights reserved.
//

import UIKit

class StoredHeroTableViewCell: UITableViewCell {

    @IBOutlet weak var alignmentLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var coverView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.heroImageView.layer.cornerRadius = 17.5
        self.heroImageView.clipsToBounds = true
        self.coverView.layer.cornerRadius = 17.5
        self.coverView.clipsToBounds = true
    }
}
