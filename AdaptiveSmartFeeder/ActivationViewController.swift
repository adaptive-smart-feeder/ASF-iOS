//
//  ActivationViewController.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 28/02/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import UIKit
import CoreBluetooth

class ActivationViewController: UIViewController, UITextFieldDelegate/*, BluetoothSerialDelegate*/ {
    
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
    
    //var pendingCommand: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        //serial = BluetoothSerial(delegate: self)
        self.activationTextField.delegate = self
        
        self.currentValue = 500
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        print("Start scanning...")
        //serial.startScan()
    }
    
    func handleTap() {
        _ = self.textFieldShouldReturn(self.activationTextField)
    }
    
    
    //MARK: Button actions
    
    
    @IBAction func activate(_ sender: Any) {
        
        BluetoothSerialHM10.instance.addCommand("ac \(self.currentValue)")
        //self.pendingCommand = "ac \(self.currentValue)"
        //self.sendCommand()
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
    
    
    //MARK: BluetoothSerial Delegate
    /*
    func sendCommand() {
        
        guard let pendingCommand = self.pendingCommand else { return }
        
        if serial.connectedPeripheral != nil {
            let data = pendingCommand.data(using: .utf8)!
            serial.sendDataToDevice(data)
        }
        else if let pendingPeripheral = serial.pendingPeripheral {
            serial.connectToPeripheral(pendingPeripheral)
        }
        else {
            serial.startScan()
        }
    }
    
    func serialDidDiscoverPeripheral(_ peripheral: CBPeripheral, RSSI: NSNumber?) {
        
        if peripheral.name == "HMSoft" {
            print("Discovered HMSoft, trying to connect...")
            serial.stopScan()
            serial.connectToPeripheral(peripheral)
        }
    }
    
    func serialDidConnect(_ peripheral: CBPeripheral) {
        
        print("Connected to HMSoft")
        
        self.sendCommand()
    }
    
    func serialDidChangeState() {
        
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        
    }
    */

}
