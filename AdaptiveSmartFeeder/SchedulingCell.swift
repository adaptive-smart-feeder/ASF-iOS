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
    
    override var reuseIdentifier: String? {
        return SchedulingCell.identifier
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.otherOptionLabel.isHidden = true
    }

    func setup(withScheduling scheduling: Scheduling ) {
        
        self.timeLabel.text = scheduling.time.description
        self.weightLabel.text = "\(scheduling.weight) g"
        self.activatedSwitch.isOn = scheduling.isActivated
    }

}
