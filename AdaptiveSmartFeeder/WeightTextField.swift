//
//  WeightTextField.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 05/03/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import UIKit

protocol WeightTextFieldDelegate {
    
    func didSetValue(to value: Int)
}

extension WeightTextFieldDelegate {
    // optional delegate method
    func didSetValue(to value: Int) {}
}

class WeightTextField: UITextField, UITextFieldDelegate {

    public var maxValue: Int = 1000
    
    private var _value: Int = 500
    
    public var value: Int {
        get {
            return _value
        }
        set {
            _value = newValue
            self.text = "\(newValue) g"
            self.weightDelegate?.didSetValue(to: newValue)
        }
    }

    private var _weightDelegate: WeightTextFieldDelegate?
    
    public var weightDelegate: WeightTextFieldDelegate? {
        get {
            return _weightDelegate
        }
        set {
            _weightDelegate = newValue
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            (self.weightDelegate as? UIViewController)?.view.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.delegate = self
    }
    
    func handleTap() {
        
        _ = self.textFieldShouldReturn(self)
    }
    
    
    //MARK: TextField Delegate
    
    
    // Remove " g" at the end and leading 0s
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        self.value = Int(text.components(separatedBy: " ").first ?? "0") ?? 0
        
        textField.text = (self.value == 0 ? "" : "\(self.value)")
    }
    
    // Add " g" at the end and limit to max value
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        guard let text = textField.text else { return }
        
        self.value = Int(text) ?? 0
        if self.value > maxValue { self.value = maxValue }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
}
