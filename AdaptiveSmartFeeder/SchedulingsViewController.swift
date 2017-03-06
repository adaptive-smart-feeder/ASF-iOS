//
//  SchedulingsViewController.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 04/03/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import UIKit

class SchedulingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    var schedulings = [Scheduling]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        schedulings = Scheduling.getSchedulings()
        self.tableView.reloadData()
    }

    func setupNavigationBar() {
        self.navigationBar.tintColor = .white
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
    
    //MARK: UITableViewDataSource
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedulings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var schedulingCell = SchedulingCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: SchedulingCell.identifier) {
            schedulingCell = cell as! SchedulingCell
        }
        
        schedulingCell.scheduling = schedulings[indexPath.row]

        return schedulingCell
    }
    
    //MARK: UITableViewDelegate
    
    
    
}
