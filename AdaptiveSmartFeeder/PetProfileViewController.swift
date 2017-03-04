//
//  PetProfileViewController.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 01/03/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import UIKit

class PetProfileViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    let pet = Pet.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupLabels()
    }
    
    func setupNavigationBar() {
        self.navigationBar.tintColor = .white
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
    func setupLabels() {
        self.nameLabel.text = pet.name
        self.birthDateLabel.text = self.getPetBirthDate()
        self.ageLabel.text = self.getPetAge()
        self.genderLabel.text = pet.gender.rawValue
        self.sizeLabel.text = pet.size.rawValue
        self.weightLabel.text = "\(pet.weight) kg"
    }
    
    func getPetBirthDate() -> String {
        
        let calendar = Calendar.current
        
        let day   = String(format:"%02d", calendar.component(.day, from: pet.birthDate))
        let month = String(format:"%02d", calendar.component(.month, from: pet.birthDate))
        let year  = calendar.component(.year, from: pet.birthDate)
        
        return "\(month)/\(day)/\(year)"
    }
    
    func getPetAge() -> String {
        
        let petAge = pet.age
        var ageText = ""
        if petAge.0 > 0 { ageText += "\(petAge.0) year\(petAge.0 > 1 ? "s" : "")" }
        if petAge.1 > 0 { ageText += " \(petAge.1) month\(petAge.1 > 1 ? "s" : "")" }

        return ageText
    }
    
}
