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
    
    var enabledDays = [Bool](repeating: false, count: 7)
    
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
    
    
    //MARK: Events
    
    
    func didTapButton(_ button: UIButton) {
    
        let tag = button.tag
        
        self.enabledDays[tag] = !self.enabledDays[tag]
        
        if(self.enabledDays[tag]) {
            button.tintColor = .white
            button.backgroundColor = orange
        }
        else {
            button.tintColor = orange
            button.backgroundColor = .white
        }
    }
    
}







