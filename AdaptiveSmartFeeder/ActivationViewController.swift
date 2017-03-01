//
//  ActivationViewController.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 28/02/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import UIKit

class ActivationViewController: ViewController, UITextFieldDelegate {
    
    @IBOutlet weak var activationTextField: UITextField!
    @IBOutlet weak var activationSlider: UISlider!
    
    let maxValue = 1000
    
    var isAutomatic: Bool! // get current status from Arduino
    
    private var _currentValue: Int!
    
    var currentValue: Int {
        get {
            return _currentValue
        }
        set {
            _currentValue = newValue
            self.activationTextField.text = "\(newValue) g"
            self.activationSlider.value = Float(newValue) / Float(maxValue)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.activationTextField.delegate = self
        
        self.currentValue = 500
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func handleTap() {
        _ = self.textFieldShouldReturn(self.activationTextField)
    }
    
    
    //MARK: Button actions
    
    
    @IBAction func activate(_ sender: Any) {
        let message = "ac \(self.currentValue)"
        print(message) // send to Arduino
    }
    
    //MARK: Switch actions
    
    
    @IBAction func activatedValueChanged(_ sender: UISwitch) {
        self.isAutomatic = sender.isOn
    }

    
    //MARK: Slider actions
    
    
    @IBAction func activationSliderValueChanged(_ sender: UISlider) {
        
        if self.activationTextField.isFirstResponder {
            self.activationTextField.resignFirstResponder()
        }
        
        self.currentValue = Int(sender.value * Float(maxValue))
    }
    
    
    //MARK: TextField Delegate
    
    
    // Remove " g" at the end and leading 0s
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        self.currentValue = Int(text.components(separatedBy: " ").first ?? "0") ?? 0
        
        textField.text = (self.currentValue == 0 ? "" : "\(self.currentValue)")
    }
    
    // Add " g" at the end and limit to max value
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        guard let text = textField.text else { return }
        
        self.currentValue = Int(text) ?? 0
        if self.currentValue > maxValue { self.currentValue = maxValue }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
