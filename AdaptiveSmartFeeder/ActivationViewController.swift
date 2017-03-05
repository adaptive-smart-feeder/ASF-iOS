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
        BluetoothSerialHM10.instance.addCommand("ac \(self.activationMode.selectedSegmentIndex) \(self.activationTextField.value)")
    }
    
    
    //MARK: Switch actions
    
    
    @IBAction func activatedValueChanged(_ sender: UISwitch) {
        self.isAutomatic = sender.isOn
        
        BluetoothSerialHM10.instance.addCommand("auto \(isAutomatic == true ? 1 : 0)")
        
        if self.isAutomatic == true {
            let pet = Pet.instance
            BluetoothSerialHM10.instance.addCommand("pet age \(pet.age.0) \(pet.age.1)")
            BluetoothSerialHM10.instance.addCommand("pet wei \(pet.weight)")
            BluetoothSerialHM10.instance.addCommand("pet siz \(pet.size.hashValue + 1)")
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
