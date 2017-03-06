//
//  SchedulingCell.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 04/03/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import UIKit

class SchedulingCell: UITableViewCell {
    
    static let identifier: String = "scheduling_cell"
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet var weekdaysLabels: [UILabel]!
    @IBOutlet weak var otherOptionLabel: UILabel!
    @IBOutlet weak var activatedSwitch: UISwitch!
    
    private var _scheduling: Scheduling!
    
    var scheduling: Scheduling {
        get {
            return _scheduling
        }
        set {
            _scheduling = newValue
            self.setup(withScheduling: _scheduling)
        }
    }
    
    override var reuseIdentifier: String? {
        return SchedulingCell.identifier
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.otherOptionLabel.isHidden = true
        
        self.weekdaysLabels.forEach {
            $0.isEnabled = false
        }
    }

    private func setup(withScheduling scheduling: Scheduling ) {
        
        self.timeLabel.text = scheduling.time.description
        self.weightLabel.text = "\(scheduling.weight) g"
        self.activatedSwitch.isOn = scheduling.isActivated
        
        let numberOfDays = scheduling.enabledDays.count
        
        if numberOfDays == 0 {
            self.setWeekdays(visible: false)
            self.otherOptionLabel.text = "Once"
        }
        else if numberOfDays == 7 {
            self.setWeekdays(visible: false)
            self.otherOptionLabel.text = "Every day"
        }
        else {
            self.setWeekdays(visible: true)
            scheduling.enabledDays.forEach { self.weekdaysLabels[$0].isEnabled = true }
        }
    }

    private func setWeekdays(visible: Bool) {
        self.weekdaysLabels.forEach { $0.isHidden = !visible }
        self.otherOptionLabel.isHidden = visible
    }
    
}
