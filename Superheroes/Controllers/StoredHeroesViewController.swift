//
//  StoredHeroesViewController.swift
//  Superheroes
//
//  Created by Elmer Astudillo on 6/22/19.
//  Copyright © 2019 Elmer Astudillo. All rights reserved.
//

import UIKit
import RealmSwift

class StoredHeroesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var heroes : Results <SuperheroRealm>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.heroes = DBManager.sharedInstance.getDataFromDB()
        self.tableView.reloadData()
    }
    
    // MARK: - Helpers
    
    func realmToObject(superheroRealm: SuperheroRealm) -> Superhero {
        let biography = Biography(alignment: superheroRealm.biography?.alignment ?? "", fullName: superheroRealm.biography?.fullName ?? "", placeOfBirth: superheroRealm.biography?.placeOfBirth ?? "", publisher: superheroRealm.biography?.publisher ?? "")
        
        let powerstats = Powerstats(combat:superheroRealm.powerstats?.combat ?? "", durability: superheroRealm.powerstats?.durability ?? "", intelligence: superheroRealm.powerstats?.intelligence ?? "", power: superheroRealm.powerstats?.power ?? "", strength: superheroRealm.powerstats?.strength ?? "", speed: superheroRealm.powerstats?.speed ?? "")
        
        let hero = Superhero(biography: biography, id: superheroRealm.id, imageURL: superheroRealm.imageURL, name: superheroRealm.name, powerstats: powerstats)
        return hero
    }
}

extension StoredHeroesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let heroes = self.heroes{
            return heroes.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StoredHeroTableViewCell
        if let heroes = heroes {
            let hero = heroes[indexPath.row]
            let url = URL(string: hero.imageURL)
            cell.alignmentLabel.text = hero.biography?.alignment
            cell.heroImageView.kf.setImage(with: url)
            cell.nameLabel.text = hero.name
            cell.publisherLabel.text = hero.biography?.publisher
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let superheroVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "superheroVC") as! SuperheroViewController
        let heroRealm = heroes![indexPath.item]
        let hero = self.realmToObject(superheroRealm: heroRealm)
        superheroVC.hero = hero
        present(superheroVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            if let hero = heroes?[indexPath.row] {
                DBManager.sharedInstance.deleteFromDb(superheroRealm: hero, powerstatsRealm: hero.powerstats!, biographyRealm: hero.biography!)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }
}
