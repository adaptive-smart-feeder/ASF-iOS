//
//  ActivationViewController.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 28/02/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import UIKit
import CoreBluetooth

class ActivationViewController: UIViewController, UITextFieldDelegate, WeightTextFieldDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var activationTextField: WeightTextField!
    @IBOutlet weak var activationSlider: UISlider!
    @IBOutlet weak var activationButton: UIButton!
    @IBOutlet weak var activationMode: UISegmentedControl!
    
    var isAutomatic: Bool!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBar()
        self.activationButton.layer.cornerRadius = 4.0
        self.activationTextField.weightDelegate = self
    }
    
    func setupNavigationBar() {
        self.navigationBar.tintColor = .white
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
    
    //MARK: WeightTextFieldDelegate
    
    
    func didSetValue(to value: Int) {
        self.activationSlider.value = Float(value) / Float(self.activationTextField.maxValue)
    }
    
    
    //MARK: Button actions
    
    
    @IBAction func activate(_ sender: Any) {
        
        let mode = self.activationMode.selectedSegmentIndex
        let quantity = self.activationTextField.value
        
        BluetoothSerialHM10.instance.addCommand(.activate(mode: mode, quantity: quantity))
    }
    
    
    //MARK: Switch actions
    
    
    @IBAction func activatedValueChanged(_ sender: UISwitch) {
        self.isAutomatic = sender.isOn
        
        BluetoothSerialHM10.instance.addCommand(.setAutomatic(automatic: isAutomatic))
        
        if self.isAutomatic == true {
            let pet = Pet.instance
            
            BluetoothSerialHM10.instance.addCommand(.updatePetData(age: pet.age, weight: pet.weight, size: pet.size))

        }
    }

    
    //MARK: Slider actions
    
    
    @IBAction func activationSliderValueChanged(_ sender: UISlider) {
        
        if self.activationTextField.isFirstResponder {
            self.activationTextField.resignFirstResponder()
        }
        
        self.activationTextField.value = Int(sender.value * Float(self.activationTextField.maxValue))
    }
    
}
