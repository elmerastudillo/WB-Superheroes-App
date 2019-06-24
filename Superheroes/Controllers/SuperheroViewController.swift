//
//  SuperheroViewController.swift
//  Superheroes
//
//  Created by Elmer Astudillo on 6/22/19.
//  Copyright © 2019 Elmer Astudillo. All rights reserved.
//

import UIKit
import SwiftCharts
import SnapKit

class SuperheroViewController: ViewController {

    @IBOutlet weak var alignmentLabel: UILabel!
    @IBOutlet weak var chartContainerView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    
    var hero: Superhero?
    var chart: BarsChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createPanGestureRecognizer()

        // Do any additional setup after loading the view.
        if let hero = self.hero {
            self.alignmentLabel.text = hero.biography?.alignment
            self.fullNameLabel.text = hero.biography?.fullName
            self.heroImageView.kf.setImage(with: URL(string: hero.imageURL))
            self.nameLabel.text = hero.name
            self.placeOfBirthLabel.text = hero.biography?.placeOfBirth
            self.publisherLabel.text = hero.biography?.publisher
        }
        
        self.saveButton.layer.cornerRadius = 0.5 * self.saveButton.bounds.size.width
        self.saveButton.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let application = UIApplication.shared.delegate as! AppDelegate
        let tabbarController = application.window?.rootViewController as! UITabBarController
        let selectedIndex = tabbarController.selectedIndex
        if selectedIndex == 1 {
            self.saveButton.removeFromSuperview()
        }
        setupChart()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let biographyRealm = BiographyRealm()
        biographyRealm.id = hero?.id ?? ""
        biographyRealm.alignment = hero?.biography?.alignment.capitalizingFirstLetter() ?? ""
        biographyRealm.fullName = hero?.biography?.fullName ?? ""
        biographyRealm.placeOfBirth = hero?.biography?.placeOfBirth ?? ""
        biographyRealm.publisher = hero?.biography?.publisher ?? ""
        let powerstatsRealm = PowerstatsRealm()
        powerstatsRealm.id = hero?.id ?? ""
        powerstatsRealm.combat = hero?.powerstats?.combat ?? ""
        powerstatsRealm.durability = hero?.powerstats?.durability ?? ""
        powerstatsRealm.intelligence = hero?.powerstats?.intelligence ?? ""
        powerstatsRealm.power = hero?.powerstats?.power ?? ""
        powerstatsRealm.speed = hero?.powerstats?.speed ?? ""
        powerstatsRealm.strength = hero?.powerstats?.strength ?? ""
        let superheroRealm = SuperheroRealm()
        superheroRealm.biography = biographyRealm
        superheroRealm.id = hero?.id ?? ""
        superheroRealm.imageURL = hero?.imageURL ?? "None"
        superheroRealm.name = hero?.name ?? ""
        superheroRealm.powerstats = powerstatsRealm
        
        DBManager.sharedInstance.addData(superheroRealm: superheroRealm, powerstatsRealm: powerstatsRealm, biographyRealm: biographyRealm)
        
        showAlert()
    }
    
    // MARK: - Helpers
    func createPanGestureRecognizer() {
        let panGesture = UIPanGestureRecognizer(target: self, action:#selector(self.panGestureRecognizerHandler))
        self.view.addGestureRecognizer(panGesture)
    }
    
    func setupChart(){
        guard let powerstats = self.hero?.powerstats else { return }
        let guidelinesConfig = GuidelinesConfig(dotted: false, lineWidth: 0.0, lineColor: .clear)
        
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 100, by: 20),
            guidelinesConfig: guidelinesConfig
        )

        let chart = BarsChart(
            frame: self.chartContainerView.bounds,
            chartConfig: chartConfig,
            xTitle: "",
            yTitle: "",
            bars: [
                ("Combat", (powerstats.combat as NSString).doubleValue),
                ("Durability", (powerstats.durability as NSString).doubleValue),
                ("Intelligence", (powerstats.intelligence as NSString).doubleValue),
                ("Power", (powerstats.power as NSString).doubleValue),
                ("Strength", (powerstats.strength as NSString).doubleValue),
                ("Speed", (powerstats.speed as NSString).doubleValue)
            ],
            color: UIColor.darkGray,
            barWidth: 30,
            horizontal: true
        )
        self.chart = chart
        self.chartContainerView.addSubview(self.chart.view)
        self.setupConstraints()
    }
    
    func setupConstraints(){
        self.chartContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.chart.view.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(15)
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Stored", message:
            "Superhero has been saved!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
