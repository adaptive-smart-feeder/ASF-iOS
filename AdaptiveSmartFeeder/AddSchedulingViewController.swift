//
//  AddSchedulingViewController.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 05/03/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import UIKit

class AddSchedulingViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var timeDatePicker: UIDatePicker!
    @IBOutlet var daysButtons: [UIButton]!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var quantitySlider: UISlider!
    
    let orange = UIColor(colorLiteralRed: 1, green: 174/255.0, blue: 0, alpha: 1)
    
    var areEnabledDays = [Bool](repeating: false, count: 7)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupButtons()
    }

    
    //MARK: Setup methods
    
    
    func setupNavigationBar() {
        self.navigationBar.tintColor = .white
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
    func setupButtons() {
        self.daysButtons.forEach {
            $0.layer.cornerRadius = 2
            $0.layer.borderWidth = 1
            $0.layer.borderColor = orange.cgColor
            $0.tintColor = orange
            $0.backgroundColor = .white
            $0.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        }
    }
    
    func getEnabledDays() -> [Int]? {
        
        if (self.areEnabledDays.filter { $0 == true }.count) == 0 {
            return nil
        }
        
        var enabledDays = [Int]()
        
        for i in (0..<7) {
            if self.areEnabledDays[i] {
                enabledDays.append(i)
            }
        }
        return enabledDays
    }
    
    
    //MARK: Events
    
    
    func didTapButton(_ button: UIButton) {
    
        let tag = button.tag
        
        self.areEnabledDays[tag] = !self.areEnabledDays[tag]
        
        if(self.areEnabledDays[tag]) {
            button.tintColor = .white
            button.backgroundColor = orange
        }
        else {
            button.tintColor = orange
            button.backgroundColor = .white
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func save(_ sender: Any) {
        
        guard let quantity = self.quantityTextField.text else {
            return
        }
        
        let calendar = Calendar.current
        
        let hours = calendar.component(.hour, from: self.timeDatePicker.date)
        let minutes = calendar.component(.minute, from: self.timeDatePicker.date)
        
        let enabledDays = self.getEnabledDays()
        
        let newScheduling = Scheduling(withWeight: Int(quantity)!, hours: hours, minutes: minutes, isActivated: true, enabledDays: enabledDays)
        
        //TODO: save newScheduling with a persistence method
        print("New scheduling: \(newScheduling)")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}







